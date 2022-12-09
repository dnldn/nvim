--Calling object from keymap.lua
local nnoremap = require("user.map").nnoremap

--Load all user commands.
local enabled = require("user.user_commands.all")

-----------------------------------------------------------------------------------------------------------------------------------------------------

--Native commands:

--Alternative to entering command line and typing :w or :q!
nnoremap("<leader>qt", "<cmd>:q!<CR>")
nnoremap("<leader>sv", "<cmd>:w<CR>")

--Tab through windows with alt + direction.
nnoremap("<A-h>", "<cmd>wincmd h<CR>")
nnoremap("<A-l>", "<cmd>wincmd l<CR>")
nnoremap("<A-j>", "<cmd>wincmd j<CR>")
nnoremap("<A-k>", "<cmd>wincmd k<CR>")

--Split window.
nnoremap("<leader>wh", "<C-w>s") --Split window horizontally.
nnoremap("<leader>wv", "<C-w>v") --Split window vertically.
nnoremap("<leader>wq", "<cmd>close<CR>") --Close current split window.
nnoremap("<A-k>", "<cmd>wincmd k<CR>")
nnoremap("<A-k>", "<cmd>wincmd k<CR>")
nnoremap("<A-k>", "<cmd>wincmd k<CR>")
-----------------------------------------------------------------------------------------------------------------------------------------------------

--Plugins:

--Opens nvim-tree. Internal bindings for that are kept in navigation.lua.
nnoremap("<A-f>", "<cmd>NvimTreeToggle<CR>")

--Opens Telescope.
nnoremap("<A-t>", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>")
nnoremap("<A-r>", "<cmd>Telescope live_grep <CR>")
nnoremap("<A-s>", "<cmd>Telescope grep_string <CR>")
nnoremap("<A-b>", "<cmd>Telescope buffers <CR>")
nnoremap("<A-/>", "<cmd>Telescope help_tags <CR>")

--Hop binding. "s" is not super useful, so we're replacing it directly.
nnoremap("s", "<cmd>HopAnywhere<CR>")

-----------------------------------------------------------------------------------------------------------------------------------------------------

--User commands:

--Open sublime at current line and column in file. Note: USE THIS AS TEMPLATE FOR FUTURE USER COMMANDS.
if enabled.sublime then nnoremap("<leader>sb", "<cmd>Sublime<CR>") end

--Toggle nvim-cmp autocompletion on/off. It's pretty damn aggressive, which is annoying when you aren't drafting new code.
if enabled.toggle_cmp then nnoremap("<leader>ac", "<cmd>CmpToggle<CR>") end


-----------------------------------------------------------------------------------------------------------------------------------------------------

--Deprecated/TODO:
--Would love to remap these, but neovim doesn't natively support cnoremap? Lunarvim has some workaround that I can't figure out here:
--https://github.com/LunarVim/LunarVim/blob/8d3f9b8bf7f5fddca2e8046a84ecbd7c3945dcba/lua/lvim/keymappings.lua : line 94 - it's being called by init as is.
--cnoremap("<C-j>", "c_CTRL-N>")
--cnoremap("<C-k>", "c_CTRL-P>"
