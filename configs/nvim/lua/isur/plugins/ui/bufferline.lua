return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"famiu/bufdelete.nvim",
	},
	config = function()
		require("bufferline").setup({
			options = {
				diagnostics = "nvim_lsp",
				offsets = { { filetype = "neo-tree", text = "File Explorer", text_align = "center" } },
			},
		})

		local bufdelete = require("bufdelete")

		local map = vim.keymap.set

		map("n", "<S-TAB>", "<Cmd>BufferLineCyclePrev<CR>", { noremap = true, silent = true, desc = "Buffer previous" })
		map("n", "<TAB>", "<Cmd>BufferLineCycleNext<CR>", { noremap = true, silent = true, desc = "Buffer next" })
		map("n", "<Leader>x", function()
			bufdelete.bufdelete(0)
		end, { noremap = true, silent = true, desc = "Buffer close" })
		map(
			"n",
			"<Leader>X",
			"<Cmd>BufferLineCloseOthers<CR>",
			{ noremap = true, silent = true, desc = "Buffer close others" }
		)
		map(
			"n",
			"<Leader>xp",
			"<Cmd>BufferLineCloseLeft<CR>",
			{ noremap = true, silent = true, desc = "Buffer close on left" }
		)
		map(
			"n",
			"<Leader>xn",
			"<Cmd>BufferLineCloseRight<CR>",
			{ noremap = true, silent = true, desc = "Buffer close on right" }
		)
	end,
}
