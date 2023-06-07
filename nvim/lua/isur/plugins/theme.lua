  return {
    -- 'folke/tokyonight.nvim',
    "Shatur/neovim-ayu",
    priority = 1000,
    config = function()
      -- vim.cmd.colorscheme 'tokyonight-storm'
      vim.cmd.colorscheme 'ayu'
    end,
  }
