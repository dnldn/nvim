--Load all user commands.
local enabled = require("user.user_commands.all")

-----------------------------------------------------------------------------------------------------------------------------------------------------

--Native commands:

--Alternative to entering command line and typing :w or :q!
--FIXME: potential footgun in future with current user_command system - vim.api.nvim_command doesn't always respond correctly when additional prompt is needed.
vim.keymap.set("n", "<leader>qt", "<cmd>NvimTreeClose<CR><cmd>:q!<CR>")
vim.keymap.set("n", "<leader>sv", "<cmd>:w<CR>")
vim.keymap.set("n", "<leader>so", "<cmd>:so<CR>")

--Tab through windows with alt + direction.
vim.keymap.set("n", "<A-h>", "<cmd>wincmd h<CR>")
vim.keymap.set("n", "<A-l>", "<cmd>wincmd l<CR>")
vim.keymap.set("n", "<A-j>", "<cmd>wincmd j<CR>") --Note: This bind will change depending on whether LSP diagnostics are toggled or not.
vim.keymap.set("n", "<A-k>", "<cmd>wincmd k<CR>") --Note: This bind will change depending on whether LSP diagnostics are toggled or not.

--Split window.
vim.keymap.set("n", "<leader>wh", "<C-w>s") --Split window horizontally.
vim.keymap.set("n", "<leader>wv", "<C-w>v") --Split window vertically.
vim.keymap.set("n", "<leader>wq", "<cmd>close<CR>") --Close current split window.

--Movement. 
vim.keymap.set("n", "<C-j>", "<C-d>zz") --Center screen after page down.
vim.keymap.set("n", "<C-k>", "<C-u>zz") --Center screen after page up.
vim.keymap.set("n", "n", "nzz") --Center screen after finding next match.
vim.keymap.set("n", "N", "Nzz") --Center screen after finding previous match.

--Marks. Other keybinds for this are set in lua/user/navigation.lua.
vim.keymap.set("n", "<A-U>", "`a")
vim.keymap.set("n", "<A-I>", "`b")
vim.keymap.set("n", "<A-O>", "`c")
vim.keymap.set("n", "<A-P>", "`d")
vim.keymap.set("n", "<A-Y>","<cmd>marks<CR>")
vim.keymap.set("n", "<A-{>","<cmd>MarkGroupLeft<CR>")
vim.keymap.set("n", "<A-}>","<cmd>MarkGroupRight<CR>")

--Remapping macros to tab in insert mode, and flipping q to executing macros.
vim.keymap.set("n", "<tab>", "q")
vim.keymap.set("n", "q", "@")

--Pasting register at beginning or end of line, adding spaces.
vim.keymap.set("n", "<leader>pe", "A <Esc>p")
vim.keymap.set("n", "<leader>pw", "_Pa <Esc>")

--Look up vim command under string in help menu.
vim.keymap.set("n", "<leader>vh", "WBvt(y:help <C-r>" .. "\"" .. "<CR>")

--Move lines up or down when they are selected.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--Retain cursor position when joining lines. Uses "i" as a temporary mark, because that's an awkward reach from m that I'm unlikely to use as a mark.
vim.keymap.set("n", "J", "miJ`i:delmarks i<CR>")

--Replace all instances of string under word in buffer. Doesn't target substrings, but be careful with this one as it can target protected terms.
vim.keymap.set("n", "<F7><F7>", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

-----------------------------------------------------------------------------------------------------------------------------------------------------

--Plugins:

--Shortcut to resync packer after sourcing and installing new plugins.
vim.keymap.set("n", "<leader>ps", "<cmd>:PackerSync<CR>")

--Opens nvim-tree. Internal bindings for that are kept in navigation.lua.
vim.keymap.set("n", "<A-f>", "<cmd>NvimTreeToggle<CR>")

--Opens Telescope.
vim.keymap.set("n", "<A-t>", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>")
vim.keymap.set("n", "<A-r>", "<cmd>Telescope live_grep <CR>")
vim.keymap.set("n", "<A-s>", "<cmd>Telescope grep_string <CR>")
vim.keymap.set("n", "<A-b>", "<cmd>Telescope buffers <CR>")
vim.keymap.set("n", "<A-/>", "<cmd>Telescope help_tags <CR>")

--Attempting some leader binds to see if they take.
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>")
vim.keymap.set("n", "<leader>fz", "<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<CR>") --Doubling up command because it uses fzf.
vim.keymap.set("n", "<leader>rg", "<cmd>Telescope live_grep <CR>") --Doubling up command because it uses rg.
vim.keymap.set("n", "<leader>fs", "<cmd>Telescope grep_string <CR>")
vim.keymap.set("n", "<leader>fb", "<cmd>Telescope buffers <CR>")
vim.keymap.set("n", "<leader>f/", "<cmd>Telescope help_tags <CR>")

--Harpoon bindings.
vim.keymap.set("n", "<leader>ha", "<cmd>HarpoonAddMark<CR>")
vim.keymap.set("n", "<leader>hd", "<cmd>HarpoonRemoveMark<CR>")
vim.keymap.set("n", "<A-y>", "<cmd>HarpoonQuickMenu<CR>")
vim.keymap.set("n", "<A-u>","<cmd>HarpoonNav1<CR>zz")
vim.keymap.set("n", "<A-i>","<cmd>HarpoonNav2<CR>zz")
vim.keymap.set("n", "<A-o>","<cmd>HarpoonNav3<CR>zz")
vim.keymap.set("n", "<A-p>","<cmd>HarpoonNav4<CR>zz")
vim.keymap.set("n", "<A-[>","<cmd>HarpoonGroupLeft<CR>")
vim.keymap.set("n", "<A-]>","<cmd>HarpoonGroupRight<CR>")

--Hop binding. "s" is the same as "xi", so we're replacing it directly.
vim.keymap.set("n", "s", "<cmd>HopAnywhere<CR>")

--Open diff using tpope fugitive plugin and split vertically. TODO: Implement git fetch, push, pull.
vim.keymap.set("n", "<leader>gs", "<cmd>Gvdiffsplit<CR>")

--Cheat sheet.
vim.keymap.set("n", "<leader>ch", "<cmd>CheatWithoutComments<CR>")
vim.keymap.set("n", "<leader>cc", "<cmd>Cheat<CR>")

-----------------------------------------------------------------------------------------------------------------------------------------------------

--User commands:

--Open sublime at current line and column in file. Note: USE THIS AS TEMPLATE FOR FUTURE USER COMMANDS.
if enabled.sublime then vim.keymap.set("n", "<leader>sb", "<cmd>Sublime<CR>") end

--Toggle nvim-cmp autocompletion on/off. It's pretty damn aggressive, which is annoying when you aren't drafting new code.
vim.keymap.set("n", "<leader>ac", "<cmd>CmpToggle<CR>")

--Toggle dark mode.
vim.keymap.set("n", "<leader>dm", "<cmd>DarkMode<CR>")

--Toggles LSP diagnostics on or off. Alters keymaps of Alt-j/k depending on state.
vim.keymap.set("n", "<A-d>", "<cmd>DisplayDiagnostics<CR>")

--Delete marks from file and make change persistent - otherwise, they will come back when session is reopened.
vim.keymap.set("n", "<leader>dl", "<cmd>DeleteMarkFromBuffer<CR>")
vim.keymap.set("n", "<leader>db", "<cmd>DeleteAllMarksFromBuffer<CR>")
