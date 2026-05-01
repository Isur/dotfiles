local map = require("isur.core.keymap").map

-- Keymaps for moving lines
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Editor: move selection [J] down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Editor: move selection [K] up" })

map({ "n", "v" }, "<Space>", "<Nop>", { silent = true, desc = "Editor: [l]eader key" })

-- Remap for dealing with word wrap
map("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, desc = "Editor: wrapped line [k] up" })
map("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, desc = "Editor: wrapped line [j] down" })

-- Remove highlights
map("n", "<leader>sn", ":nohl<CR>", { desc = "Search: [s]earch [n]o highlights" })

-- Buffers
map("n", "<leader>bn", ":bnext<CR>", { desc = "Buffer: [b]uffer [n]ext" })
map("n", "<leader>bp", ":bprevious<CR>", { desc = "Buffer: [b]uffer [p]revious" })

map("n", "<leader>bd", ":bd<CR>", { desc = "Buffer: [b]uffer [d]elete" })
map("n", "<leader>bD", ":bd!<CR>", { desc = "Buffer: [b]uffer force [D]elete" })
map("n", "<leader>ba", ":%bd|e#|bd#<CR>", { desc = "Buffer: [b]uffer delete [a]ll but current" })

map("v", "p", '"_dP', { desc = "Editor: [p]aste without yank" })

-- Select all
map("n", "<C-a>", "ggVG", { desc = "Editor: select [a]ll" })

-- file path
map("n", "<leader>fp", function()
	local path = vim.fn.expand("%")
	print(path)
	vim.fn.setreg("+", path) -- Copy to system clipboard
end, { desc = "Editor: [f]ile [p]ath copy" })
