return {
	"nvim-neo-tree/neo-tree.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},

	config = function()
		vim.keymap.set("n", "<leader>fe", vim.cmd.Neotree, { desc = "File Explorer" })
		vim.keymap.set("n", "<leader>fq", "<Cmd>Neotree close<CR>", { desc = "File Explorer Quit" })

		local neotree = require("neo-tree")

		vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
		neotree.setup({
			close_if_last_window = true,
			enable_git_status = true,
			enable_diagnostics = true,
			window = {
				position = "right",
			},
			event_handlers = {
				{
					event = "file_opened",
					handler = function(file_path)
						-- uncomment if want to auto close tree
						-- neotree.close_all()
					end,
				},
			},
			filesystem = {
				follow_current_file = {
					enabled = true,
				},
			},
		})
	end,
}
