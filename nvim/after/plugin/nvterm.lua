local nvterm = require("nvterm")
local term = require("nvterm.terminal")

nvterm.setup()

vim.keymap.set({"n", "t"}, "<leader>nn",function()
  term.toggle("float")
end, { desc = "NvTermToggle Float" })

vim.keymap.set({"n", "t"}, "<leader>ns",function()
  term.toggle("horizontal")
end, { desc = "NvTermToggle Horizontal" })


vim.keymap.set({"n", "t"}, "<leader>nv",function()
  term.toggle("vertical")
end, { desc = "NvTermToggle Vertical" })

