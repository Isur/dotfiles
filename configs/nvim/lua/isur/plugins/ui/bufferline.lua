return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	init = function()
		vim.g.barbar_auto_setup = false
	end,
	opts = {},
	version = "^1.0.0",
	config = function()
		local bufferline = require("barbar")
		local map = vim.api.nvim_set_keymap
		local function opts(desc)
			return { noremap = true, silent = true, desc = desc }
		end

		bufferline.setup()

		-- Move to previous/next
		map("n", "<S-TAB>", "<Cmd>BufferPrevious<CR>", opts("Buffer previous"))
		map("n", "<TAB>", "<Cmd>BufferNext<CR>", opts("Buffer next"))
		-- Re-order to previous/next
		-- map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
		-- map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)
		-- Goto buffer in position...
		-- map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
		-- map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
		-- map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
		-- map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
		-- map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
		-- map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
		-- map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
		-- map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
		-- map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
		-- map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
		-- Pin/unpin buffer
		-- map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
		-- Close buffer
		map("n", "<Leader>x", "<Cmd>BufferClose<CR>", opts("Buffer close"))
		map("n", "<Leader>X", "<Cmd>BufferCloseAllButCurrent<CR>", opts("Buffer close all but current"))
		map("n", "<Leader>xn", "<Cmd>BufferCloseBuffersRight<CR>", opts("Buffer buffers on right"))
		map("n", "<Leader>xp", "<Cmd>BufferCloseBuffersLeft<CR>", opts("Buffer buffers on left"))
		-- Wipeout buffer
		--                 :BufferWipeout
		-- Close commands
		--                 :BufferCloseAllButCurrent
		--                 :BufferCloseAllButPinned
		--                 :BufferCloseAllButCurrentOrPinned
		--                 :BufferCloseBuffersLeft
		--                 :BufferCloseBuffersRight
		-- Magic buffer-picking mode
		-- map('n', '<A-p>', '<Cmd>BufferPick<CR>', opts)
		-- Sort automatically by...
		-- map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
		-- map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
		-- map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
		-- map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

		-- Other:
		-- :BarbarEnable - enables barbar (enabled by default)
		-- :BarbarDisable - very bad command, should never be used
	end,
}
