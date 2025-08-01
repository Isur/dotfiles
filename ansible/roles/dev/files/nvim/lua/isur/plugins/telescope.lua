return {
	"nvim-telescope/telescope.nvim",
	-- branch = "0.1.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		"nvim-tree/nvim-web-devicons",
		"folke/todo-comments.nvim",
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")
		local themes = require("telescope.themes")
		local gfh_actions = require("telescope").extensions.git_file_history.actions

		telescope.setup({
			extensions = {
				git_file_history = {
					mappings = {
						i = {
							["<C-g>"] = gfh_actions.open_in_browser,
						},
						n = {
							["<C-g>"] = gfh_actions.open_in_browser,
						},
					},

					-- The command to use for opening the browser (nil or string)
					-- If nil, it will check if xdg-open, open, start, wslview are available, in that order.
					browser_command = nil,
				},
			},
			defaults = {
				mappings = {
					n = {
						["<C-d>"] = actions.delete_buffer,
					},
					i = {
						["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
					},
				},
				layout_strategy = "vertical",
				layout_config = {
					vertical = {
						width = 0.8,
						height = 0.9,
					},
					horizontal = {
						width = 0.8,
						height = 0.8,
					},
				},
				dynamic_preview_title = true,
				border = false, -- TODO: remove when telescope/plenary fix issues with `winborder` https://github.com/nvim-telescope/telescope.nvim/issues/3436#issuecomment-2766504120
			},
		})

		telescope.load_extension("fzf")
		telescope.load_extension("git_file_history")

		vim.keymap.set("n", "<leader>?", builtin.oldfiles, { desc = "Find recently opened files" })
		vim.keymap.set(
			"n",
			"<leader><space>",
			"<cmd>Telescope buffers initial_mode=normal<cr>",
			{ desc = "Find existing buffers" }
		)
		vim.keymap.set("n", "<leader>/", function()
			builtin.current_buffer_fuzzy_find(themes.get_dropdown({
				winblend = 10,
				previewer = false,
			}))
		end, { desc = "Fuzzily search in current buffer" })

		vim.keymap.set("n", "<leader>gf", builtin.git_files, { desc = "Search Git Files" })
		vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
		vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
		vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search keymaps" })
		vim.keymap.set("n", "<leader>sw", builtin.grep_string, { desc = "Search current Word" })
		vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "Search previously opened files" })
		vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
		vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
		vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "Search Quick fix" })
		vim.keymap.set("n", "<leader>ds", builtin.lsp_document_symbols, { desc = "Document symbols" })
		vim.keymap.set("n", "<leader>st", "<cmd>TodoTelescope<cr>", { desc = "Search Todo/Note/Fixme" })
	end,
}
