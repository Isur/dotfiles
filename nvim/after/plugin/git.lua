vim.keymap.set("n", "<leader>gg", vim.cmd.LazyGit, { desc = "Lazy Git" })

local gitsigns = require('gitsigns')

gitsigns.setup({
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    vim.keymap.set('n', '<leader>gp', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Go to previous hunk' })
    vim.keymap.set('n', '<leader>gn', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Go to next hunk' })
    vim.keymap.set('n', '<leader>ph', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview hunk' })
  end,
})
