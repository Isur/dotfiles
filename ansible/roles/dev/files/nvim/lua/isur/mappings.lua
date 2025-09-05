-- Keymaps for moving lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "{V} Move Selected Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "{V} Move Selected Up" })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Remove highlights
vim.keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Buffers
vim.keymap.set("n", "<TAB>", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-TAB>", ":bprevious<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>x", ":bd<CR>", { desc = "Close buffer" })

vim.keymap.set("n", "<leader>sc", function()
	vim.o.spell = not vim.o.spell
end, { desc = "Toggle spellcheck" })

-- file path
vim.keymap.set("n", "<leader>fp", function()
	local path = vim.fn.expand("%")
	print(path)
	vim.fn.setreg("+", path) -- Copy to system clipboard
end, { desc = "Copy file path" })
