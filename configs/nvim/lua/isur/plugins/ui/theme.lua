return {
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		local gruvbox = require("gruvbox")
		gruvbox.setup({
			overrides = {
				SignColumn = { bg = "#282828" },
				TabLineFill = { bg = "#282828" },
				TabLineSel = { fg = "#fe8019" },
			},
		})
		vim.o.background = "dark"
		vim.cmd.colorscheme("gruvbox")

		-- Fix background color of floating windows
		vim.api.nvim_set_hl(0, "FloatBorder", { link = "Normal" })
		vim.api.nvim_set_hl(0, "NormalFloat", { bg = "#282828" })
	end,
}
