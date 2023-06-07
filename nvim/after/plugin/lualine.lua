local lualine = require('lualine')
lualine.setup({
  options = {
    icons_enabled = true,
    theme = 'nightfly',
    section_separators = { left = '', right = '' },
    component_separators = { left = '', right = '' }
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'filetype'},
    lualine_y = {'location', 'diagnostics'},
    lualine_z = {'progress'},
  },
  winbar = {
    -- lualine_a= {'filename'},
    -- lualine_b= {'filename'},
    -- lualine_c= {'filename'},
    -- lualine_x= {'filename'},
    -- lualine_y= {'filename'},
    -- lualine_z= {'progress'},
  },
  tabline = {
    -- lualine_a= {'filename'},
    -- lualine_b= {'filename'},
    -- lualine_c= {'filename'},
    -- lualine_x= {'filename'},
    -- lualine_y= {'filename'},
    -- lualine_z= {'location'},
  },
})
