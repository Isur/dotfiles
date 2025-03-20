return {
	base46 = {
		theme = "flexoki",
		hl_override = {
			Comment = { italic = true },
			["@comment"] = { italic = true },
			FloatBorder = { fg = "#555050" },
		},
		transparency = false,
		theme_toggle = {
			"flexoki",
			"ayu",
		},
	},
	ui = {
		cmp = {
			lspkind_text = true,
			style = "default", -- default/flat_light/flat_dark/atom/atom_colored
			format_colors = {
				tailwind = false,
			},
		},
		tabufline = {
			order = { "treeOffset", "buffers", "tabs" },
			modules = {},
		},
		statusline = {
			theme = "vscode_colored",
			order = {
				-- "isRecording",
				"supermaven",
				"mode",
				"file",
				"git",
				"%=",
				"lsp_msg",
				"%=",
				"diagnostics",
				"lsp",
				"cursor",
				"filePercentage",
				"cwd",
			},
			-- default order
			-- default = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cwd", "cursor" },
			--  vscode = { "mode", "file", "git", "%=", "lsp_msg", "%=", "diagnostics", "lsp", "cursor", "cwd" },
			modules = {
				isRecording = function()
					local reg = vim.fn.reg_recording()
					if reg == "" then
						return " [_] "
					end -- not recording
					return " [" .. reg .. "] "
				end,
				filePercentage = "%p%% ",
				supermaven = function()
					local sm = require("supermaven-nvim.api")
					return sm.is_running() and " [SM] " or ""
				end,
			},
		},
		telescope = { style = "bordered" }, -- borderless / bordered
	},
	lsp = {
		signature = false,
	},
	colorify = {
		enabled = true,
	},
}
