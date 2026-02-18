return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")

			gitsigns.setup({
				diff_opts = {
					ignore_whitespace_change_at_eol = true,
				},
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					vim.keymap.set("n", "<leader>gp", function()
						gitsigns.nav_hunk("prev", {})
					end, { buffer = bufnr, desc = "Go to previous hunk" })
					vim.keymap.set("n", "<leader>gn", function()
						gitsigns.nav_hunk("next")
					end, { buffer = bufnr, desc = "Go to next hunk" })
					vim.keymap.set("n", "<leader>gh", gitsigns.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
					vim.keymap.set("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
					vim.keymap.set("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
				end,
			})
		end,
	},
	{
		-- "sindrets/diffview.nvim",
		"esmuellert/codediff.nvim",
		opts = {
			diff = {
				ignore_trim_whitespace = true,
			},
		},
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Neogit",
		keys = {
			{ "<leader>gg", "<cmd>Neogit<cr>", desc = "Show Neogit UI" },
		},
	},
}
