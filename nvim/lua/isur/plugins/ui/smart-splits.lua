return {
	"mrjones2014/smart-splits.nvim",
	config = function()
		local smartsplits = require("smart-splits")

		smartsplits.setup({})
		-- resizing splits
		vim.keymap.set("n", "<C-w>h", smartsplits.resize_left)
		vim.keymap.set("n", "<C-w>j", smartsplits.resize_down)
		vim.keymap.set("n", "<C-w>k", smartsplits.resize_up)
		vim.keymap.set("n", "<C-w>l", smartsplits.resize_right)
		-- moving between splits
		vim.keymap.set("n", "<C-h>", smartsplits.move_cursor_left)
		vim.keymap.set("n", "<C-j>", smartsplits.move_cursor_down)
		vim.keymap.set("n", "<C-k>", smartsplits.move_cursor_up)
		vim.keymap.set("n", "<C-l>", smartsplits.move_cursor_right)
		-- swapping buffers between windows
		vim.keymap.set("n", "<leader><leader>h", smartsplits.swap_buf_left)
		vim.keymap.set("n", "<leader><leader>j", smartsplits.swap_buf_down)
		vim.keymap.set("n", "<leader><leader>k", smartsplits.swap_buf_up)
		vim.keymap.set("n", "<leader><leader>l", smartsplits.swap_buf_right)
	end,
}
