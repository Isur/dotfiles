return {
	"folke/trouble.nvim",
	requires = {
		"kyazdani42/nvim-web-devicons",
	},
	config = function()
		require("trouble").setup({})

		vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>TroubleToggle<cr>", { noremap = true, silent = true })
	end,
}
