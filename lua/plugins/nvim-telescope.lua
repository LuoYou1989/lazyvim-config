return {
    "nvim-telescope/telescope.nvim",
    config = function ()
        local telescope = require("telescope")
        local telescopeConfig = require("telescope.config")

        -- Clone the default Telescope configuration
        local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

        -- I want to search in hidden/dot files.
        table.insert(vimgrep_arguments, "--hidden")
        -- I don't want to search in the `.git` directory.
        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/local_data/*")

        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/gamelog/*")

        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/log/*")

        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.svn/*")

        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!**/.idea/*")

        table.insert(vimgrep_arguments, "--glob")
        table.insert(vimgrep_arguments, "!tags")

        telescope.setup({
            defaults = {
                -- `hidden = true` is not supported in text grep commands.
                vimgrep_arguments = vimgrep_arguments,
            },
            pickers = {
                find_files = {
                    file_ignore_patterns = {"%.beam$"},      -- 忽略.beam文件
                    -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
                    find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*", "--glob", "!**/.svn/*" , "--glob", "!**/.idea/*"},
                },
            },
        })
    end
}
