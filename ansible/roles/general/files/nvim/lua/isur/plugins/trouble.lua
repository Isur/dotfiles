return {
	"folke/trouble.nvim",
	dependencies = {
		"folke/todo-comments.nvim",
	},
	opts = {
		max_items = 5000,
		modes = {
			symbols = {
				win = {
					size = 0.3,
				},
			},
		},
	}, -- for default options, refer to the configuration section for custom setup.
	cmd = "Trouble",
	keys = {
		{
			"<leader>dd",
			"<cmd>Trouble diagnostics toggle focus=true<cr>",
			desc = "Trouble Diagnostics",
		},
		{
			"<leader>dx",
			"<cmd>Trouble diagnostics toggle focus=true filter.buf=0<cr>",
			desc = "Trouble Buffer Diagnostics",
		},
		{
			"<leader>ds",
			"<cmd>Trouble symbols toggle fold_close_all focus=true<cr>",
			desc = "Trouble Symbols",
		},
		{
			"<leader>dt",
			"<cmd>Trouble todo toggle focus=true<cr>",
			desc = "Trouble Todos",
		},
	},
}
