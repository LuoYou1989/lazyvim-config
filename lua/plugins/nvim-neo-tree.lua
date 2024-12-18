return {
    "nvim-neo-tree/neo-tree.nvim",
    config = function ()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            default_component_configs = {
                indent = {
                  indent_size = 2,
                  padding = 1,
                  with_markers = true,
                  indent_marker = "│",
                  last_indent_marker = "└",
                  highlight = "NeoTreeIndentMarker",
                },
                icon = {
                  folder_closed = "",
                  folder_open = "",
                  folder_empty = "ﰊ",
                  default = "",
                },
                name = {
                  trailing_slash = false,
                  use_git_status_colors = true,
                  highlight = "NeoTreeFileName",
                },
                git_status = {
                  symbols = {
                    added     = "✚",
                    modified  = "",
                    deleted   = "✖",
                    renamed   = "",
                    untracked = "",
                    ignored   = "",
                    unstaged  = "",
                    staged    = "",
                    conflict  = "",
                  }
                },
            },
        })
    end
}
