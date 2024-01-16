return {
    "nvim-lualine/lualine.nvim",
    config = function()
        local lualine = require('lualine')

        lualine.setup({
          options = {
            icons_enabled = true,
            -- theme = 'gruvbox_dark',
            theme = 'tokyonight',
            section_separators = { left = '', right = '' },
            component_separators = { left = '', right = '' }
          },
          sections = {
            lualine_a = {'mode'},
            lualine_b = {'branch'},
            lualine_c = {{'filename', path = 1}},
            lualine_x = {'copilot', 'encoding', 'filetype'},
            lualine_y = {'location'},
            lualine_z = {'diagnostics', 'progress'},
          },
          inactive_sections = {
            lualine_a = {'filename'},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
          },
          winbar = {
            -- lualine_a= {'branch'},
            -- lualine_b= {'filename'},
            -- lualine_c= {'filename'},
            -- lualine_x= {'filename'},
            -- lualine_y= {'filename'},
            -- lualine_z= {'progress'},
          },
          tabline = {
            -- lualine_a= { 'filename' },
            -- lualine_b= {'tabs'},
            -- lualine_c= {'buffers'},
            -- lualine_x= {'filename'},
            -- lualine_y= {'filename'},
            -- lualine_z= {'location'},
          },
        })
    end
}
