--Calling object from keymap.lua
local nnoremap = require("user.map").nnoremap

--Load all user commands.
local enabled = require("user.user_commands.all")

-----------------------------------------------------------------------------------------------------------------------------------------------------

--Native commands:

--Alternative to entering command line and typing :w or :q!
--TODO: potential footgun in future with current user_command system - vim.api.nvim_command wasn't responding correctly when additional prompt was needed. 
nnoremap("<leader>qt", "<cmd>NvimTreeClose<CR><cmd>:q!<CR>")
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

--Movement. 
nnoremap("<C-j>", "<C-d>zz") --Center screen after page down.
nnoremap("<C-k>", "<C-u>zz") --Center screen after page up.

--Remapping macros to tab in insert mode, and flipping q to executing macros. TODO: Check for clashes on snippets with tab.
nnoremap("<tab>", "q")
nnoremap("q", "@")

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

--Attempting some leader binds to see if they take.
nnoremap("<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>")
nnoremap("<leader>fz", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>") --Doubling up command because it uses fzf.
nnoremap("<leader>fg", "<cmd>Telescope live_grep <CR>")
nnoremap("<leader>rg", "<cmd>Telescope live_grep <CR>") --Doubling up command because it uses rg.
nnoremap("<leader>fs", "<cmd>Telescope grep_string <CR>")
nnoremap("<leader>fb", "<cmd>Telescope buffers <CR>")
nnoremap("<leader>f/", "<cmd>Telescope help_tags <CR>")

--Harpoon bindings.
nnoremap("<leader>ha", "<cmd>HarpoonAddMark<CR>")
nnoremap("<A-y>", "<cmd>HarpoonQuickMenu<CR>")
nnoremap("<A-u>","<cmd>HarpoonNav1<CR>")
nnoremap("<A-i>","<cmd>HarpoonNav2<CR>")
nnoremap("<A-o>","<cmd>HarpoonNav3<CR>")
nnoremap("<A-p>","<cmd>HarpoonNav4<CR>")
nnoremap("<A-[>","<cmd>HarpoonGroupLeft<CR>")
nnoremap("<A-]>","<cmd>HarpoonGroupRight<CR>")

--Hop binding. "s" is the same as "xi", so we're replacing it directly.
nnoremap("s", "<cmd>HopAnywhere<CR>")

--Open diff using tpope fugitive plugin and split vertically. TODO: Implement git fetch, push, pull.
nnoremap("<leader>gs", "<cmd>Gvdiffsplit<CR>")

-----------------------------------------------------------------------------------------------------------------------------------------------------

--User commands:

--Open sublime at current line and column in file. Note: USE THIS AS TEMPLATE FOR FUTURE USER COMMANDS.
if enabled.sublime then nnoremap("<leader>sb", "<cmd>Sublime<CR>") end

--Toggle nvim-cmp autocompletion on/off. It's pretty damn aggressive, which is annoying when you aren't drafting new code.
if enabled.toggle_cmp then nnoremap("<leader>ac", "<cmd>CmpToggle<CR>") end

--Quit current buffer and close nvim-tree.
-- if enabled.close_buffer then nnoremap("<leader>qt", "<cmd>QTBuffer<CR>") end
