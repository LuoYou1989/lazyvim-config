-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local ls = require("luasnip")
vim.keymap.set("n", "<leader>od", "<cmd>!chdir.sh explorer.exe /select, %<cr>")
vim.keymap.set("n", "<leader>of", "<cmd>!chdir.sh explorer.exe /select, %<cr>")
vim.keymap.set("i", '<c-j>', function () ls.jump(1) end, {silent = true})
vim.keymap.set("i", '<c-k>', function () ls.jump(-1) end, {silent = true})
vim.keymap.set("i", "<c-f>", function () ls.expand_or_jump() end, {silent = true})
vim.keymap.set("v", "<c-f>", function () ls.expand_or_jump() end, {silent = true})
vim.keymap.set("n", "<leader>svn", "<cmd>!TortoiseProc.exe /command:commit /path:\".\" /coloseonend:4 /configdi:\".\" <cr>")
vim.api.nvim_set_keymap('i', '<Tab>', '\t', {noremap = true, silent = true})
--vim.keymap.set("i", "<Tab>", function () ls.expand() end, {silent = true})
