local keymap = require("isur.core.keymap")

return {
	"tpope/vim-fugitive",
	"tpope/vim-rhubarb",
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			local map = require("isur.core.keymap").map
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
					map("n", "<leader>gp", function()
						gitsigns.nav_hunk("prev", {})
					end, { buffer = bufnr, desc = "Git: [g]it [p]revious hunk" })
					map("n", "<leader>gn", function()
						gitsigns.nav_hunk("next")
					end, { buffer = bufnr, desc = "Git: [g]it [n]ext hunk" })
					map("n", "<leader>gh", gitsigns.preview_hunk, { buffer = bufnr, desc = "Git: [g]it [h]unk preview" })
					map("n", "<leader>gs", gitsigns.stage_hunk, { buffer = bufnr, desc = "Git: [g]it [s]tage hunk" })
					map("n", "<leader>gr", gitsigns.reset_hunk, { buffer = bufnr, desc = "Git: [g]it [r]eset hunk" })
				end,
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
	},
	{
		"NeogitOrg/neogit",
		lazy = true,
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		cmd = "Neogit",
		keys = {
			keymap.lazy("<leader>gg", "<cmd>Neogit<cr>", { desc = "Git: [g]it neo[g]it" }),
		},
	},
}
