--Set space as leader key.
vim.g.mapleader = " "

--Disable skinny cursor in insert mode.
vim.opt.guicursor = ""

--Setting relative line numbers.
vim.opt.nu = true
vim.opt.relativenumber = true

--No indenting and no line wraps by default.
vim.opt.smartindent = true
vim.opt.wrap = false

--Fixing tab spacing to be a little more reasonable.
vim.opt.tabstop = 6
vim.opt.softtabstop = 6
vim.opt.shiftwidth = 6

--Disable persistent highlighting on search, and show incremental changes.
vim.opt.hlsearch = false
vim.opt.incsearch = true

--Default is 4000 - this can hypothetically cause some issue with swap files, but it should make things a little more responsive?
vim.opt.updatetime = 50
