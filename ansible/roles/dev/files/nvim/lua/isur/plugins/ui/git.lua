return {
	"kdheepak/lazygit.nvim",
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"isak102/telescope-git-file-history.nvim",
		dependencies = { "tpope/vim-fugitive" },
		config = function()
			vim.keymap.set("n", "<leader>gh", ":Telescope git_file_history<CR>", { desc = "Git file history" })
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "Lazy Git" })
			-- vim.keymap.set("n", "<leader>gh", ":Git log --oneline -p --follow -- % <CR>", { desc = "Git file history" })

			local gitsigns = require("gitsigns")

			gitsigns.setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					vim.keymap.set(
						"n",
						"<leader>gp",
						gitsigns.prev_hunk,
						{ buffer = bufnr, desc = "Go to previous hunk" }
					)
					vim.keymap.set("n", "<leader>gn", gitsigns.next_hunk, { buffer = bufnr, desc = "Go to next hunk" })
					vim.keymap.set("n", "<leader>ph", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
					vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
				end,
			})
		end,
	},
}
