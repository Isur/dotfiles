return {
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup()
	-- 		vim.cmd("colorscheme catppuccin-macchiato")
	-- 	end,
	-- },
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({})
		end,
	},
	{
		"dgox16/oldworld.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			require("oldworld").setup()
			vim.cmd.colorscheme("oldworld")
		end,
	},
}
