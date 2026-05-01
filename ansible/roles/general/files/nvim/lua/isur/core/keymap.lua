local M = {}

---@class IsurKeymapEntry
---@field mode string[]
---@field lhs string
---@field desc string
---@field buffer? integer
---@field source string

---In-memory keymap registry used to generate docs.
---@type IsurKeymapEntry[]
M.registry = {}

---Normalize a mode value to a list for consistent storage.
---@param mode string|string[]
---@return string[]
local function normalize_modes(mode)
	if type(mode) == "table" then
		return mode
	end
	return { mode }
end

---Get caller source path from Lua debug info.
---@param level integer
---@return string
local function source_path(level)
	local info = debug.getinfo(level, "S")
	if not info or not info.source then
		return "unknown"
	end
	return info.source:gsub("^@", "")
end

---Add one mapping entry to the registry.
---@param entry IsurKeymapEntry
local function register(entry)
	table.insert(M.registry, entry)
end

---@param lhs string
---@return string
local function normalize_lhs(lhs)
	if type(lhs) ~= "string" or lhs == "" then
		return lhs
	end
	local leader = vim.g.mapleader
	if type(leader) == "string" and leader ~= "" and lhs:sub(1, #leader) == leader then
		return "<leader>" .. lhs:sub(#leader + 1)
	end
	return lhs
end

---@param source string
---@return string
local function trim_source_prefix(source)
	local config_dir = vim.fn.stdpath("config") .. "/"
	if source:sub(1, #config_dir) == config_dir then
		return source:sub(#config_dir + 1)
	end
	return source
end

---@param entries IsurKeymapEntry[]
---@param include_runtime boolean
---@return IsurKeymapEntry[]
local function collect_entries(entries, include_runtime)
	local rows = {}
	for _, entry in ipairs(entries) do
		table.insert(rows, entry)
	end

	if not include_runtime then
		return rows
	end

	local modes = { "n", "v", "x", "s", "o", "i", "c", "t" }
	for _, mode in ipairs(modes) do
		for _, km in ipairs(vim.api.nvim_get_keymap(mode)) do
			if (km.sid or 0) > 0 then
				table.insert(rows, {
					mode = { mode },
					lhs = km.lhs,
					desc = km.desc or "",
					source = "runtime:global",
				})
			end
		end
	end

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(bufnr) then
			for _, mode in ipairs(modes) do
				for _, km in ipairs(vim.api.nvim_buf_get_keymap(bufnr, mode)) do
					if (km.sid or 0) > 0 then
						table.insert(rows, {
							mode = { mode },
							lhs = km.lhs,
							desc = km.desc or "",
							buffer = bufnr,
							source = "runtime:buffer",
						})
					end
				end
			end
		end
	end

	return rows
end

---@param rows IsurKeymapEntry[]
---@return string[]
local function collision_lines(rows)
	local by_key = {}
	for _, row in ipairs(rows) do
		local mode = table.concat(row.mode, ",")
		local key = mode .. "|" .. row.lhs
		by_key[key] = by_key[key] or {}
		table.insert(by_key[key], row)
	end

	local lines = { "", "## Collisions", "" }
	local has = false

	local function is_runtime_source(source)
		return type(source) == "string" and source:sub(1, 8) == "runtime:"
	end

	local function source_class(entries)
		local has_runtime = false
		local has_config = false
		for _, e in ipairs(entries) do
			if is_runtime_source(e.source) then
				has_runtime = true
			else
				has_config = true
			end
		end
		return has_runtime, has_config
	end

	for key, entries in pairs(by_key) do
		local unique = {}
		for _, e in ipairs(entries) do
			local tag = (e.desc or "") .. "|" .. (e.source or "") .. "|" .. tostring(e.buffer or "")
			unique[tag] = true
		end

		local has_runtime, has_config = source_class(entries)
		if has_runtime and has_config then
			local semantic = {}
			for _, e in ipairs(entries) do
				local scope = e.buffer and ("buffer:" .. tostring(e.buffer)) or "global"
				local skey = (e.desc or "") .. "|" .. scope
				semantic[skey] = true
			end
			local semantic_count = 0
			for _ in pairs(semantic) do
				semantic_count = semantic_count + 1
			end
			if semantic_count == 1 then
				goto continue
			end
		end

		local count = 0
		for _ in pairs(unique) do
			count = count + 1
		end
		if count > 1 then
			has = true
			local mode, lhs = key:match("^(.-)|(.+)$")
			table.insert(lines, string.format("- `%s` `%s` has %d mappings:", mode, lhs, count))
			for _, e in ipairs(entries) do
				local d = e.desc ~= "" and e.desc or "(no description)"
				local s = trim_source_prefix(e.source or "unknown")
				local scope = e.buffer and ("buffer " .. e.buffer) or "global"
				table.insert(lines, string.format("  - %s | %s | %s", d, scope, s))
			end
		end
		::continue::
	end

	if not has then
		table.insert(lines, "- No collisions detected.")
	end

	return lines
end

---Register a normal keymap and track it in the registry.
---Use this instead of vim.keymap.set in your config.
---`lhs` is the key sequence you press (e.g. `<leader>ff`, `gd`, `zR`).
---`rhs` is what runs when `lhs` is pressed (command string or Lua function).
---`mode` is where the mapping applies (`n`, `i`, `v`, `x`, `o`, etc.).
---Common `opts`: `desc` (shown in which-key/docs), `buffer` (buffer-local),
---`silent` (no command echo), `expr` (evaluate rhs as expression).
---@param mode string|string[]
---@param lhs string
---@param rhs string|function
---@param opts? table
function M.map(mode, lhs, rhs, opts)
	opts = opts or {}
	vim.keymap.set(mode, lhs, rhs, opts)

	register({
		mode = normalize_modes(mode),
		lhs = lhs,
		desc = opts.desc or "",
		buffer = opts.buffer,
		source = opts.source or source_path(3),
	})
end

---Register a lazy.nvim `keys` mapping and track it in the registry.
---Returns the same shape lazy.nvim expects: { lhs, rhs, ...opts }.
---`lhs` is the trigger key sequence in lazy's key spec.
---`rhs` is the action bound to `lhs` (string command or function callback).
---`opts.mode` controls mapping modes (defaults to `n` when omitted).
---Other useful `opts`: `desc`, `ft`, `silent`, `expr`, `remap`.
---@param lhs string
---@param rhs string|function
---@param opts? table
---@return table
function M.lazy(lhs, rhs, opts)
	opts = opts or {}
	local mode = opts.mode or "n"

	register({
		mode = normalize_modes(mode),
		lhs = lhs,
		desc = opts.desc or "",
		source = opts.source or source_path(3),
	})

	local mapping = { lhs, rhs }
	for k, v in pairs(opts) do
		mapping[k] = v
	end

	return mapping
end

---Export the current registry to markdown.
---By default writes to `<config>/keybind-list.md`.
---@param file_path? string
---@param file_path? string
---@param include_runtime? boolean
function M.export(file_path, include_runtime)
	if not file_path or file_path == "" then
		local name = include_runtime and "keybind-list-all.md" or "keybind-list.md"
		file_path = vim.fn.stdpath("config") .. "/" .. name
	end
	local rows = collect_entries(M.registry, include_runtime == true)

	table.sort(rows, function(a, b)
		local am = table.concat(a.mode, ",")
		local bm = table.concat(b.mode, ",")
		if am ~= bm then
			return am < bm
		end
		if a.lhs ~= b.lhs then
			return a.lhs < b.lhs
		end
		return (a.desc or "") < (b.desc or "")
	end)

	local lines = {
		"# Keybind List",
		"",
		"Generated from `isur.core.keymap` registry.",
		"Run `:KeymapsExport` to refresh.",
		"",
		"| Mode | Key | Description | Scope | Source |",
		"| --- | --- | --- | --- | --- |",
	}

	local seen = {}
	for _, row in ipairs(rows) do
		local mode = table.concat(row.mode, ",")
		local lhs = normalize_lhs(row.lhs)
		local desc = row.desc ~= "" and row.desc or "(no description)"
		local scope = row.buffer and "buffer-local" or "global"
		local source = trim_source_prefix(row.source or "unknown")
		local dedupe_key = mode .. "|" .. lhs .. "|" .. desc .. "|" .. scope
		if not seen[dedupe_key] then
			seen[dedupe_key] = true
			table.insert(lines, string.format("| `%s` | `%s` | %s | %s | `%s` |", mode, lhs, desc, scope, source))
		end
	end

	for _, line in ipairs(collision_lines(rows)) do
		table.insert(lines, line)
	end

	vim.fn.writefile(lines, file_path)
	vim.notify("Exported keymaps to " .. file_path)
end

if not vim.g.isur_keymaps_export_command then
	vim.api.nvim_create_user_command("KeymapsExport", function(opts)
		local target = opts.args ~= "" and opts.args or nil
		M.export(target)
	end, {
		nargs = "?",
		desc = "Export registered keymaps to markdown",
	})
	vim.api.nvim_create_user_command("KeymapsExportAll", function(opts)
		local target = opts.args ~= "" and opts.args or nil
		M.export(target, true)
	end, {
		nargs = "?",
		desc = "Export registered and runtime keymaps to markdown",
	})
	vim.g.isur_keymaps_export_command = true
end

return M
