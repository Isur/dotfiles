return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		-- add any options here
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		-- "rcarriga/nvim-notify",
	},
	config = function()
		local noice = require("noice")

		vim.keymap.set("n", "<leader>nl", function()
			noice.cmd("last")
		end, { desc = "Noice last" })

		vim.keymap.set("n", "<leader>hr", function()
			noice.cmd("history")
		end, { desc = "Noice history" })

		vim.keymap.set("n", "<leader>nc", function()
			noice.cmd("dismiss")
		end, { desc = "Noice clear" })

		noice.setup({
			routes = {
				{
					filter = {
						event = "notify",
						find = "No information available",
					},
					opts = {
						skip = true,
					},
				},
			},
			lsp = {
				signature = {
					enabled = false,
				},
			},
		})
	end,
}
