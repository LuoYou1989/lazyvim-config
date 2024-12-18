if true then return {} end
return {
    "nvimdev/dashboard-nvim",
    config = function ()
        require("dashboard").setup({
            theme = 'hyper',
            config = {
                week_header = {
                    enable = true,
                },
                shortcut = {
                    {
                        desc = 'Update',
                        group = '@property',
                        action = 'Lazy update',
                        key = 'u'
                    },
                    {
                        icon = '',
                        icon_hl = '@variable',
                        desc = 'Files',
                        group = 'Label',
                        action = 'Telescope find_files',
                        key = 'f',
                    },
                    {
                        desc = 'Apps',
                        group = 'DiagnosticHint',
                        action = 'Telescope app',
                        key = 'a',
                    },
                    {
                        desc = 'Dotfiles',
                        group = 'Number',
                        action = 'Telescope dotfiles',
                        key = 'd',
                    },
                },
                center = {
                    {
                        icon = '',
                        icon_hl = 'group',
                        desc = 'description',
                        desc_hl = 'group',
                        key = 'shortcut key in dashboard buffer not keymap !!',
                        key_hl = 'group',
                        key_format = ' [%s]', -- `%s` will be substituted with value of `key`
                        action = '',
                    },
                },
                project = {
                    enable = true,
                    limit = 8,
                    icon = 'Recent Projects',
                    label = '',
                    action = 'Telescope find_files cwd='
                },
                mru = {
                    limit = 10,
                    icon = 'Most Recent Files',
                    label = '',
                    cwd_only = false
                },
                packages = {
                    enable = true
                },
                -- show how many plugins neovim loaded
                footer = {},
                hide = {
                    statusline = false,    -- hide statusline default is true
                    tabline = false,       -- hide the tabline
                    winbar = false,        -- hide winbar
                },
            },
        })
    end
}
