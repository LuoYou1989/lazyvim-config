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
                            local client = vim.tbl_get(message.opts, "progress", "client")
                            return client == "erlangls"
                        end,
                    },
                    opts = { skip = true },
                },
            },
        })
    end
}
