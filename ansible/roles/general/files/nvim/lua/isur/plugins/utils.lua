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
}
