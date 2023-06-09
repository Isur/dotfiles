local dapPython = require("dap-python")

vim.opt_local.colorcolumn = '100'

vim.keymap.set("n", "<leader>tt", function()
  dapPython.test_method()
end, { desc = "Python run test method"})

vim.keymap.set("n", "<leader>tT", function()
  dapPython.test_class()
end, { desc = "Python run test class"})

local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
dapPython.setup(path)
