--Disabling netrw so it doesn't conflict with nvimtree.
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

--Set bindings in list = {{key =}} section.
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
	{ key = { "l", "<CR>", "o" }, action = "edit", mode = "n" },
	{ key = "h", action = "close_node" },
	{ key = "v", action = "vsplit" },
	{ key = "C", action = "cd" }
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
})

---------------------------------------------------------------------------------------------------

--Importing telescope: TODO - refactor with local function register.
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then return end

--Importing telescope actions. Refactor here as well.
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then return end

--Configure telescope.
telescope.setup({
  --Configure custom mappings.
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, --Send selected to quick fix list.
      },
    },
  },
})

--Extension with improved fuzzy find performance.
telescope.load_extension("fzf")

---------------------------------------------------------------------------------------------------

--Importing harpoon: TODO: implement mark navigation with same system.

local harpoon_setup, harpoon = pcall(require, "harpoon")
if not harpoon_setup then return end

--Registering global variables to determine which buffers in quick menu are being hotkeyed to.
_HarpoonIndex = 1
_HarpoonSceneTable = {1, 5, 9, 13, 17, 21, 25, 29, 33, 37, 41, 45, 49, 53, 57, 61}

--Configure harpoon.
harpoon.setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 4,
	}
})

--Registering harpoon commands as actions to keep keymap.lua clean.
vim.api.nvim_create_user_command("HarpoonAddMark", function() require("harpoon.mark").add_file() end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonRemoveMark", function() require("harpoon.mark").rm_file() end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonQuickMenu", function() require("harpoon.ui").toggle_quick_menu() end, {nargs = 0})

--Navigation commands:

	--Alt-u, Alt-i, Alt-o, Alt-p access four consecutive buffers as populated in Harpoon's quick menu.

vim.api.nvim_create_user_command("HarpoonNav1", function() require("harpoon.ui").nav_file(_HarpoonSceneTable[_HarpoonIndex]+0) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav2", function() require("harpoon.ui").nav_file(_HarpoonSceneTable[_HarpoonIndex]+1) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav3", function() require("harpoon.ui").nav_file(_HarpoonSceneTable[_HarpoonIndex]+2) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav4", function() require("harpoon.ui").nav_file(_HarpoonSceneTable[_HarpoonIndex]+3) end, {nargs = 0})


--Clamping is needed for the next two commands and lua doesn't implement it for some reason...
local function clamp(x, min, max) if x < min then return min elseif x > max then return max else return x end end


	--Alt-[ moves the selection back by four buffers
	--Alt-] moves the selection forward by four buffers.
	--These allow me to tab quickly without pulling up the UI menu.


--Get a multiple from current number of buffers, and move down by four. Clamp so value rounds down to zero if less than 1.
vim.api.nvim_create_user_command("HarpoonGroupLeft",  function()
	local current_max = math.floor((require("harpoon.mark").get_length()-1)/4)+1
	if current_max == 0 then _HarpoonIndex = 1 return
	else
		_HarpoonIndex = clamp(_HarpoonIndex - 1, 1, current_max)
		vim.api.nvim_command("echo \"" .. "Buffer " .. _HarpoonSceneTable[_HarpoonIndex] .. " through " .. _HarpoonSceneTable[_HarpoonIndex] + 4 .. " selected." .. "\"")
	end
end, {nargs = 0})

--Get a multiple from current number of buffers, and move up by four. Clamp so value rounds down to a maximum defined by current number of buffers.
vim.api.nvim_create_user_command("HarpoonGroupRight", function()
	local current_max = math.floor((require("harpoon.mark").get_length()-1)/4)+1
	if current_max == 0 then _HarpoonIndex = 1 return
	else
		_HarpoonIndex = clamp(_HarpoonIndex + 1, 1, current_max)
		vim.api.nvim_command("echo \"" .. "Buffer " .. _HarpoonSceneTable[_HarpoonIndex] .. " through " .. _HarpoonSceneTable[_HarpoonIndex] + 4 .. " selected." .. "\"")
	end
end, {nargs = 0})
