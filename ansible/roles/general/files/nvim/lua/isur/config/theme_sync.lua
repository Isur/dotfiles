local group = vim.api.nvim_create_augroup("ThemeSync", { clear = true })

local fallback_bg = "#24273a"
local fallback_fg = "#cad3f5"

local function to_hex(value)
	if type(value) ~= "number" then
		return nil
	end
	return string.format("#%06x", value)
end

local function hex_to_rgb(hex)
	local clean = hex:gsub("#", "")
	if #clean ~= 6 then
		return nil
	end
	local value = tonumber(clean, 16)
	if not value then
		return nil
	end
	local r = math.floor(value / 65536) % 256
	local g = math.floor(value / 256) % 256
	local b = value % 256
	return r, g, b
end

local function clamp_channel(value)
	if value < 0 then
		return 0
	end
	if value > 255 then
		return 255
	end
	return value
end

local function rgb_to_hex(r, g, b)
	return string.format("#%02x%02x%02x", clamp_channel(r), clamp_channel(g), clamp_channel(b))
end

local function adjust_channel(value, delta)
	return clamp_channel(math.floor(value + delta + 0.5))
end

local function luminance(r, g, b)
	return (0.2126 * r) + (0.7152 * g) + (0.0722 * b)
end

local function hover_from_bg(bg_hex)
	local r, g, b = hex_to_rgb(bg_hex)
	if not r then
		return bg_hex
	end
	local lum = luminance(r, g, b)
	local delta = 32
	if lum > 160 then
		delta = -delta
	end
	return rgb_to_hex(adjust_channel(r, delta), adjust_channel(g, delta), adjust_channel(b, delta))
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

local function write_waybar_theme(colors)
	local config_dir = vim.fn.expand("~/.config/waybar")
	vim.fn.mkdir(config_dir, "p")
	local path = config_dir .. "/theme.css"
	local hover = hover_from_bg(colors.bg)
	local lines = {
		"@define-color bg " .. colors.bg .. ";",
		"@define-color bg-hover " .. hover .. ";",
		"@define-color c " .. colors.fg .. ";",
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
	write_waybar_theme(colors)
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
