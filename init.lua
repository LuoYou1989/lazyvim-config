-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").erlangls.setup({handlers = {
    ["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            -- 取消虚拟文本
            virtual_text = false
        }
    ),
    }
})
-- 更改符号列（装订线）中的诊断符号
local signs = { Error = "EE", Warn = "WN", Hint = "HI", Info = "IN" }
for type, icon in pairs(signs) do
    local hl = "DiagnosticSign" .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end
-- 将诊断信息打印到消息区域
function PrintDiagnostics(opts, bufnr, line_nr, _)
    bufnr = bufnr or 0
    line_nr = line_nr or (vim.api.nvim_win_get_cursor(0)[1] - 1)
    opts = opts or {['lnum'] = line_nr}

    local line_diagnostics = vim.diagnostic.get(bufnr, opts)
    if vim.tbl_isempty(line_diagnostics) then return end

    local diagnostic_message = ""
    for i, diagnostic in ipairs(line_diagnostics) do
        diagnostic_message = diagnostic_message .. string.format("%d: %s", i, diagnostic.message or "")
        print(diagnostic_message)
        if i ~= #line_diagnostics then
            diagnostic_message = diagnostic_message .. "\n"
        end
    end
    vim.api.nvim_echo({{diagnostic_message, "Normal"}}, false, {})
end
vim.api.nvim_create_autocmd("CursorHold", {
    group = vim.api.nvim_create_augroup("print_diagnostics", { clear = true }),
    callback = PrintDiagnostics
})
