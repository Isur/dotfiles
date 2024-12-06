return {
	"rest-nvim/rest.nvim",
	"tpope/vim-sleuth",
	"christoomey/vim-tmux-navigator",
	{
		"folke/which-key.nvim",
		config = function()
			require("which-key").setup()
		end,
	},
	{
		"szw/vim-maximizer",
		keys = {
			{ "<leader>mm", ":MaximizerToggle<CR>", desc = "Maximize/minimize the split" },
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local ibl = require("ibl")
			ibl.setup({
				enabled = true,
			})
		end,
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
		"github/copilot.vim",
		depenencies = { "ofseed/lualine-copilot" },
		event = "InsertEnter",
		config = function()
			vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
				expr = true,
				replace_keycodes = false,
			})
			vim.g.copilot_no_tab_map = true
		end,
	},
}
