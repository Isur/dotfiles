local keymap = require("isur.core.keymap")

return {
	"tpope/vim-sleuth",
	"neovim/nvim-lspconfig",
	"christoomey/vim-tmux-navigator",
	{
		"szw/vim-maximizer",
		keys = {
			keymap.lazy("<leader>mm", ":MaximizerToggle<CR>", { desc = "UI: [m]aximizer [m]ode" }),
		},
	},
	{
		"sphamba/smear-cursor.nvim",
		opts = {
			stiffness = 0.8,
			trailing_stiffness = 0.6,
			stiffness_insert_mode = 0.7,
			trailing_stiffness_insert_mode = 0.7,
			damping = 0.95,
			damping_insert_mode = 0.95,
			distance_stop_animating = 0.5,
		},
	},
	{
		"karb94/neoscroll.nvim",
		opts = {
			duration_multiplier = 0.3,
		},
	},
}
