vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })
vim.keymap.set("n", "<leader>db", vim.cmd.DapToggleBreakpoint, { desc = "Dap Toggle Breakpoing" } )

local dap = require("dap")
local dapui = require("dapui")

vim.keymap.set("n", "<leader>tq", function()
  dapui.close()
end, { desc = "Test quit"})

dapui.setup()

dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

