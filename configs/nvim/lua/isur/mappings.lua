-- Keymap for showing explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Explorer" })
-- Keymaps for moving lines

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "{V} Move Selected Down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "{V} Move Selected Up" })

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
