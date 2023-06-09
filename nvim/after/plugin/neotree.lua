vim.keymap.set("n", "<leader>fe", vim.cmd.Neotree, { desc = "[F]ile [E]xplorer" })
vim.keymap.set("n", "<leader>fq", vim.cmd.NeoTreeClose, { desc = "[F]ile Explorer [Q]uit" })

local neotree = require("neo-tree")

vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])
neotree.setup({
  close_if_last_window = true,
  enable_git_status = true,
  enable_diagnostics = true,
  event_handlers = {
    {
      event = "file_opened",
      handler = function(file_path)
        -- uncomment if want to auto close tree
        -- neotree.close_all()
      end
    }
  },
  filesystem = {
    follow_current_file = true
  }
})
