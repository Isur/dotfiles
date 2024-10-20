return {
	base46 = {
		theme = "gruvchad",
		transparency = false,
		theme_toggle = {
			"gruvchad",
			"ayu",
		},
	},
	ui = {
		tabufline = {
			order = { "treeOffset", "buffers", "tabs" },
			modules = {},
		},
		statusline = {
			theme = "vscode_colored",
			order = {
				"isRecording",
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
			},
		},
		telescope = { style = "bordered" }, -- borderless / bordered
	},
	lsp = {
		signature = true,
	},
	colorify = {
		enabled = true,
	},
}
