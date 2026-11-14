return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = true,
		opts = {},
	},
	{
		"rebelot/kanagawa.nvim",
		opts = {},
		lazy = true,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		opts = {},
		lazy = true,
	},
	{
		"navarasu/onedark.nvim",
		opts = {
			style = "darker",
		},
		lazy = true,
	},
	{
		"folke/tokyonight.nvim",
		opts = {},
		lazy = true,
	},
	{
		"AlexvZyl/nordic.nvim",
		opts = {},
		lazy = true,
	},
	{
		"tiagovla/tokyodark.nvim",
		opts = {},
		lazy = true,
	},
	{
		"nuvic/flexoki-nvim",
		name = "flexoki",
		opts = {},
		lazy = true,
	},
	{
		"ficcdaf/ashen.nvim",
		name = "ashen",
		opts = {},
		lazy = true,
	},
	{
		"Shatur/neovim-ayu",
		name = "ayu",
		lazy = true,
	},
	{
		"RRethy/base16-nvim",
		lazy = true,
	},
	{
		-- This is just for applying the selected colorscheme as default one.
		name = "apply-colorscheme",
		dir = vim.fn.stdpath("config"),
		lazy = false,
		priority = 900,
		init = function()
			local ok, _ = pcall(function()
				require("matugen").setup()
			end)
			if not ok then
				vim.cmd.colorscheme("kanagawa")
			end
		end,
	},
}
