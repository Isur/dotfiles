return {
  "ellisonleao/gruvbox.nvim",
  name = "gruvbox",
  priority = 1000,
  config = function()
    vim.o.background = "dark"
    vim.cmd.colorscheme 'gruvbox'
  end,
}
