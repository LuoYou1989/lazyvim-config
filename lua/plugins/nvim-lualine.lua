return{
    "nvim-lualine/lualine.nvim"
    , version = "*"
    , config = function ()
        require('lualine').setup {
            options = {
--                icons_enabled = false,
--                component_separators = { left = '', right = ''},
--                section_separators = { left ='', right = ''},
                theme = 'auto',
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                globalstatus = false,
                refresh = {
                    statusline = 1000,
                    tabline = 1000,
                    winbar = 1000,
                }
            },
            sections = {
                lualine_a = {'mode'},
                lualine_b = {'branch', 'diff', 'diagnostics'},
                lualine_c = {'filename'},
                lualine_d = {'filesize'},
                lualine_x = {'fileformat','encoding', 'filetype'},
                lualine_y = {'location'},
                lualine_z = {'progress'}
            },
            inactive_sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = {'filename'},
                lualine_x = {'location'},
                lualine_y = {},
                lualine_z = {}
            },
            tabline = {},
            winbar = {},
            inactive_winbar = {},
            extensions = {}
        }

    end
}
