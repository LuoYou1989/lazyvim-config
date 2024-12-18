-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- 编码方式 utf8
vim.o.fenc = "utf-8"
vim.o.fencs = "utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,big-5,unicode,gb2313"
vim.o.fileformats = "unix,dos,mac"
-- vim.o.termencoding = "utf8"
vim.g.encoding = "UTF-8"
vim.o.fileencoding = "utf-8"
-- jkhl 移动时光标周围保留8行
vim.o.scrolloff = 10
vim.o.sidescrolloff = 10
-- 显示行号
vim.wo.number = true
-- 使用相对行号
vim.wo.relativenumber = false
-- 高亮所在行
vim.wo.cursorline = true
-- 显示左侧图标指示列
vim.wo.signcolumn = "auto"
-- 右侧参考线
-- vim.wo.colorcolumn = "160"
-- 缩进字符
vim.o.tabstop = 4
vim.bo.tabstop = 4
vim.o.softtabstop = 4
vim.o.shiftround = true
-- >> << 时移动长度
vim.o.shiftwidth = 4
vim.bo.shiftwidth = 4
-- 空格替代tab
vim.o.expandtab = true
vim.bo.expandtab = true
-- 新行对齐当前行
vim.o.autoindent = true
vim.bo.autoindent = true
vim.o.smartindent = true
-- 搜索大小写不敏感，除非包含大写
vim.o.ignorecase = true
vim.o.smartcase = true
-- 搜索高亮
vim.o.hlsearch = true
vim.o.incsearch = true
-- 命令模式行高
vim.o.cmdheight = 1
-- 自动加载外部修改
vim.o.autoread = true
vim.bo.autoread = true
-- 禁止折行
vim.wo.wrap = true
-- 光标在行首尾时<Left><Right>可以跳到下一行
vim.o.whichwrap = "<,>,[,]"
-- 允许隐藏被修改过的buffer
vim.o.hidden = true
-- 鼠标支持
vim.o.mouse = "a" -- 禁止创建备份文件
vim.o.backup = false
vim.o.writebackup = false
vim.o.swapfile = false
vim.o.undofile = false
-- smaller updatetime
vim.o.updatetime = 300
vim.o.timeoutlen = 500
vim.o.splitbelow = true
vim.o.splitright = true
-- 自动补全不自动选中
vim.g.completeopt = "menu,menuone,noselect,noinsert"
-- 样式
-- vim.o.background = "dark"
vim.o.termguicolors = true
vim.opt.termguicolors = true
-- 不可见字符的显示，这里只把空格显示为一个点
vim.o.list = false
vim.o.listchars = "space:·,tab:>-"
vim.o.wildmenu = true
vim.o.shortmess = vim.o.shortmess .. "c"
-- 设置自动格式化
vim.g.autoformat = false
-- 设置leader键
vim.g.mapleader = " "
-- 设置自定义状态
vim.o.statusline = "%f %h%m%r%r%=%-35(%l,%c [0x%B] (%L lines) [%{&ff}:%{&fenc}] %y%) %P"
-- 设置符号列自动 使用:verbose set signcolumn? 显示当前值
vim.api.nvim_command([[
    autocmd VimEnter,WinEnter * setlocal signcolumn=auto            
]])

--vim.keymap.set('n', '<leader>of', '<cmd>!explorer.exe /select, %<cr>', {desc = 'explorer open curr file'})
--vim.keymap.set('n', '<leader>of', '<cmd>!echo %<cr>', {desc = 'explorer open curr file'})
vim.keymap.set('n', '<leader>od', '<cmd>!explorer.exe . <cr>', {desc = 'explorer open curr dir'})

-- vim.opt.colorcolumn = "molokai"
-- vim.api.nvim_command([[
--     colorscheme molokai
-- ]])
