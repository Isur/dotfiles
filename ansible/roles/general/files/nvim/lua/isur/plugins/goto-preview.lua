return {
	"rmagatti/goto-preview",
	dependencies = { "rmagatti/logger.nvim" },
	config = function()
		local gt = require("goto-preview")
		gt.setup({})

		vim.keymap.set({ "n" }, "<leader>kk", function()
			gt.goto_preview_definition({})
		end, { silent = true, noremap = true, desc = "Show preview definition window" })

		vim.keymap.set({ "n" }, "<leader>kq", function()
			gt.close_all_win()
		end, { silent = true, noremap = true, desc = "Close all preview windows" })

		vim.keymap.set({ "n" }, "<leader>kt", function()
			gt.goto_preview_type_definition({})
		end, { silent = true, noremap = true, desc = "Show preview type window" })

		vim.keymap.set({ "n" }, "<leader>kr", function()
			gt.goto_preview_references()
		end, { silent = true, noremap = true, desc = "Show preview references window" })

		vim.keymap.set({ "n" }, "<leader>ki", function()
			gt.goto_preview_implementation({})
		end, { silent = true, noremap = true, desc = "Show preview implementation window" })
	end,
}
