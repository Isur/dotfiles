return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		local map = require("isur.core.keymap").map
		local ufo = require("ufo")
		vim.o.foldcolumn = "0"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		map("n", "zR", ufo.openAllFolds, { desc = "Fold: [z] fold open [R]" })
		map("n", "zM", ufo.closeAllFolds, { desc = "Fold: [z] fold close [M]" })
		map("n", "zK", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Fold: [z] fold pee[K]" })

		ufo.setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
}
