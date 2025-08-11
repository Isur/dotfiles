return {
	"tpope/vim-sleuth",
	"christoomey/vim-tmux-navigator",
	{
		"Tsuzat/NeoSolarized.nvim",
		lazy = false, -- make sure we load this during startup if it is your main colorscheme
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			vim.cmd("colorscheme NeoSolarized")
		end,
	},
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup({
				preset = "helix",
			})
		end,
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>mm", ":MaximizerToggle<CR>", desc = "Maximize/minimize the split" },
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			-- Usage:
			-- HACK:
			-- BUG:
			-- TODO:
			-- NOTE:
			-- FIXME:
			-- FIX:
			-- FIXIT:
			-- WARN:
			-- TEST:
			require("todo-comments").setup({})
		end,
	},
	{
		"jiaoshijie/undotree",
		dependencies = "nvim-lua/plenary.nvim",
		event = { "BufReadPost" },
		config = true,
		keys = { -- load the plugin only when using it's keybinding:
			{ "<leader>u", "<cmd>lua require('undotree').toggle()<cr>" },
		},
	},
	{
		"supermaven-inc/supermaven-nvim",
		config = function()
			require("supermaven-nvim").setup({
				condition = function()
					return vim.env.NVIM_SUPERMAVEN == "off"
				end,
			})
		end,
	},
}
