local dapPython = require("dap-python")

vim.keymap.set("n", "<leader>tt", function()
  dapPython.test_method()
end, { desc = "Test run test method"})

vim.keymap.set("n", "<leader>tT", function()
  dapPython.test_class()
end, { desc = "Test run Test class"})

local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
dapPython.setup(path)
