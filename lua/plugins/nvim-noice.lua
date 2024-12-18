return {
    "folke/noice.nvim",
    config = function ()
        require("noice").setup({
            routes = {
                {
                    filter = {
                        event = "lsp",
                        kind = "progress",
                        cond = function(message)
                            if type(message.opts) ~= "table" then
                                return false
                            end
                            local progress = vim.tbl_get(message.opts, "progress")
                            if type(progress) ~= "table" then
                                return false
                            end
                            local client = vim.tbl_get(progress, "client")
                            local title = vim.tbl_get(progress, "title")
                            if client == "erlangls" then
                                if string.sub(title, 1, 8) == "Indexing" then
                                    return true
                                end
                            end
                            return false
                        end,
                    },
                    opts = { skip = true },
                },
            },
        })
    end
}
