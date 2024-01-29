return {
	-- "folke/tokyonight.nvim",
	"ellisonleao/gruvbox.nvim",
	lazy = false,
	priority = 1000,
	opts = {},

	config = function()
		-- vim.cmd.colorscheme("tokyonight-night")
		vim.o.background = "dark"
		vim.cmd.colorscheme("gruvbox")
	end,
}
