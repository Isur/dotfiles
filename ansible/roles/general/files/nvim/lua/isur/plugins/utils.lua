return {
	"tpope/vim-sleuth",
	"neovim/nvim-lspconfig",
	"christoomey/vim-tmux-navigator",
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup()
			vim.cmd("colorscheme catppuccin-macchiato")
		end,
	},
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup({})
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
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
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
