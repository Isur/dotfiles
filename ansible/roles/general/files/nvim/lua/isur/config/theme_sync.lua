local group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })

local fallback_bg = "#24273a"
local fallback_fg = "#cad3f5"

local function to_hex(value)
	if type(value) ~= "number" then
		return nil
	end
	return string.format("#%06x", value)
end

local function get_theme_colors()
	local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
	local normal_nc = vim.api.nvim_get_hl(0, { name = "NormalNC", link = false })

	local bg = to_hex(normal.bg) or to_hex(normal_nc.bg) or fallback_bg
	local fg = to_hex(normal.fg) or to_hex(normal_nc.fg) or fallback_fg

	return {
		bg = bg,
		fg = fg,
	}
end

local function write_tmux_colors(colors)
	local path = vim.fn.expand("~/.tmux.colors")
	local lines = {
		'set -g @theme_bg "' .. colors.bg .. '"',
		'set -g @theme_accent "' .. colors.fg .. '"',
	}
	vim.fn.writefile(lines, path)
end

local function reload_tmux()
	if not vim.env.TMUX then
		return
	end

	local path = vim.fn.expand("~/.tmux.colors")
	vim.fn.system({ "tmux", "source-file", path })
	vim.fn.system({ "tmux", "refresh-client", "-S" })
end

local function sync_theme()
	local colors = get_theme_colors()
	write_tmux_colors(colors)
	reload_tmux()
end

vim.api.nvim_create_autocmd("ColorScheme", {
	group = group,
	callback = function()
		vim.schedule(sync_theme)
	end,
})

vim.api.nvim_create_autocmd("VimEnter", {
	group = group,
	callback = function()
		vim.schedule(sync_theme)
	end,
})
