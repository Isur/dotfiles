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

vim.keymap.set("n", "<leader>bd", ":bd<CR>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bD", ":bd!<CR>", { desc = "Force delete buffer" })
vim.keymap.set("n", "<leader>ba", ":%bd|e#|bd#<CR>", { desc = "Delete all buffers except current" })

vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yank" })

-- Select all
vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select all" })

-- file path
vim.keymap.set("n", "<leader>fp", function()
	local path = vim.fn.expand("%")
	print(path)
	vim.fn.setreg("+", path) -- Copy to system clipboard
end, { desc = "Copy file path" })
