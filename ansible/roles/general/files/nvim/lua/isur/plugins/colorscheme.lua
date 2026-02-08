return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		opts = {},
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {},
		priority = 1000,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {},
		priority = 1000,
	},
	{
		"navarasu/onedark.nvim",
		opts = {
			style = "darker",
		},
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		opts = {},
		priority = 1000,
	},
	{
		"AlexvZyl/nordic.nvim",
		opts = {},
		priority = 1000,
	},
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		priority = 1000,
	},
	{
		"nuvic/flexoki-nvim",
		name = "flexoki",
		opts = {},
		priority = 1000,
	},
	{
		"ficcdaf/ashen.nvim",
		name = "ashen",
		opts = {},
		priority = 1000,
	},
	{
		"Shatur/neovim-ayu",
		lazy = false,
		priority = 1000,
		name = "ayu",
	},
	{
		-- This is just for applying the selected colorscheme as default one.
		name = "apply-colorscheme",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 900,
		init = function()
			local theme = "ayu"
			vim.cmd.colorscheme(theme)
		end,
	},
}
