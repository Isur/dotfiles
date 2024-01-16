return {
	"filipdutescu/renamer.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		vim.api.nvim_set_keymap(
			"i",
			"<F2>",
			'<cmd>lua require("renamer").rename()<cr>',
			{ noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"n",
			"<leader>rn",
			'<cmd>lua require("renamer").rename()<cr>',
			{ desc = "Rename", noremap = true, silent = true }
		)
		vim.api.nvim_set_keymap(
			"v",
			"<leader>rn",
			'<cmd>lua require("renamer").rename()<cr>',
			{ desc = "Rename", noremap = true, silent = true }
		)

		local renamer = require("renamer")

		renamer.setup({
			title = "Rename",
		})
	end,
}
