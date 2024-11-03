return {
	"kevinhwang91/nvim-ufo",
	dependencies = {
		"kevinhwang91/promise-async",
	},
	config = function()
		local ufo = require("ufo")
		vim.o.foldcolumn = "0"
		vim.o.foldlevel = 99
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true

		vim.keymap.set("n", "zR", ufo.openAllFolds, { desc = "Open all folds " })
		vim.keymap.set("n", "zM", ufo.closeAllFolds, { desc = "Close all folds " })
		vim.keymap.set("n", "zK", function()
			local winid = ufo.peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peak Fold" })

		ufo.setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
}
