vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.smartindent = true
vim.opt.wrap = false

--Set space as leader key.
vim.g.mapleader = " "

--Default is 4000 - this can hypothetically cause some issue with swap files, but it should make things a little more responsive?
vim.opt.updatetime = 50
