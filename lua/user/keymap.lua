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

--Split window.
vim.keymap.set("n", "<leader>wh", "<C-w>s") --Split window horizontally.
vim.keymap.set("n", "<leader>wv", "<C-w>v") --Split window vertically.
vim.keymap.set("n", "<leader>wq", "<cmd>close<CR>") --Close current split window.

--Movement. 
vim.keymap.set("n", "<C-j>", "<C-d>zz") --Center screen after page down.
vim.keymap.set("n", "<C-k>", "<C-u>zz") --Center screen after page up.
vim.keymap.set("v", "<C-j>", "20j") --Move selection down by 20 in visual mode.
vim.keymap.set("v", "<C-k>", "20k") --Move selection up by 20 in visual mode.
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

--Toggle word wrap.
vim.keymap.set("n", "<leader>sw", ":set wrap<CR>")


--Copying/pasting in visual mode.
vim.keymap.set('v', '<C-c>', '"+y')
vim.keymap.set('v', '<C-v>', '"+p')

--Look up vim command under string in help menu.
vim.keymap.set("n", "<leader>vh", "WBvt(y:help <C-r>" .. "\"" .. "<CR>")

--Move lines up or down when they are selected.
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

--Retain cursor position when joining lines. Uses "i" as a temporary mark, because that's an awkward reach from m that I'm unlikely to use as a mark.
vim.keymap.set("n", "J", "miJ`i:delmarks i<CR>")

--Replace all instances of string under word in buffer. Doesn't target substrings, but be careful with this one as it can target protected terms.
vim.keymap.set("n", "<F7><F7>", [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]])

--Open command line with clipboard or register to lua execute command.
vim.keymap.set("n", "<leader>pc", ":<C-R>+")
vim.keymap.set("n", "<leader>pr", ':lua <C-r>"')
vim.keymap.set("n", "<leader>hi", "<cmd>hi<CR>")

--Clear line to black hole register and escape.
vim.keymap.set("n", "<leader>dd", '"_cc<Esc>')
vim.keymap.set("v", "<leader>dd", '"_dd<Esc>')


vim.keymap.set("n", "<CR>", "o<Esc>k")
vim.keymap.set("n", "<A-Enter>", "O<Esc>j")

--TODO: Add guardrailing at top or bottom of session.
--TODO: Add support for languages where vim's comment syntax defaults to wrapper-style comments (C++, java, HTML).
function _InsertEmptyLinesAroundCurrentLine()

	--Gap is magic numbered to two for now - I really don't see a need to add more options based on my use case.
	local gap = 2
	local delimiter = comment .. "*** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** *** ***"

	--Get line, column, and buffer from cursor position.
	local current = {}
	current.row, current.col = unpack(vim.api.nvim_win_get_cursor(0))

	--Iterate only through lines in range of current buffer.
	local emptyLines = true
	local lines = vim.api.nvim_buf_get_lines(0, current.row-1-gap, current.row+gap, true)

	for n, line in ipairs(lines) do
		if n ~= center_idx then
			if line ~= "" and line ~= delimiter then
				emptyLines = false
				break
			end
		end
	end

	--Get current line.
	local current_line = {tostring(vim.api.nvim_get_current_line())}

	if emptyLines then

		--Delete space.
		vim.api.nvim_buf_set_text(0, current.row-1-gap, 0, current.row-1+gap, 0, current_line)

		--Move cursor back to position and clean up delimiter.
		vim.api.nvim_win_set_cursor(0, {current.row-gap, current.col})
		vim.api.nvim_set_current_line(current_line[1])

	else

		--Create replacement lines.
		local replace_lines = {delimiter, "", tostring(vim.api.nvim_get_current_line()), "", delimiter}

		--Create spaces above and below text.
		local a1 = "normal " .. gap .. "O"
		local a2 = "normal j"
		local a3 = "normal " .. gap .. "o"
		local a4 = "normal 2k"

		--Do replacement on temporary text.
		vim.cmd(a1) vim.cmd(a2) vim.cmd(a3) vim.cmd(a4)
		vim.api.nvim_buf_set_lines(0, current.row-1, current.row+(gap*2), true, replace_lines)

		--Move cursor back to position.
		vim.api.nvim_win_set_cursor(0, {current.row+gap, current.col})
	end
end

vim.keymap.set("n", "<leader>oi", ":lua _InsertEmptyLinesAroundCurrentLine()<CR>")

----------------------------------------------------------------------------------------------------------------------------------------------------------------
--Plugins: (Note - all CoC keybinds are in coc.lua.

vim.keymap.set("n", "<leader>ps", "<cmd>:PackerSync<CR>")

--Opens nvim-tree. Internal bindings for that are kept in navigation.lua.
vim.keymap.set("n", "<A-f>", "<cmd>NvimTreeToggle<CR>")

--CoC Keybinds.

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

--Toggles LSP or COC diagnostics on or off. Alters keymaps of Alt-j/k depending on state in LSP implementation. Disables both autocomplete and diagnostics in COC implementation.
vim.keymap.set("n", "<leader>dg", "<cmd>DisplayDiagnostics<CR>")

--Delete marks from file and make change persistent - otherwise, they will come back when session is reopened.
vim.keymap.set("n", "<leader>dl", "<cmd>DeleteMarkFromBuffer<CR>")
vim.keymap.set("n", "<leader>db", "<cmd>DeleteAllMarksFromBuffer<CR>")
