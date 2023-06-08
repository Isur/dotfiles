local jest = require("nvim-jest")

vim.keymap.set("n", "<leader>tt", vim.cmd.JestSingle, { desc = "Jester run test"})
vim.keymap.set("n", "<leader>tT", vim.cmd.JestFile, { desc = "Jester run file test"})
vim.keymap.set("n", "<leader>tp", vim.cmd.JestCoverage, { desc = "Jester run project" })

jest.setup({})
