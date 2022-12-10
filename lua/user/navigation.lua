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

--Importing harpoon: TODO: if I stick with this, place it above telescope as harpoon will integrate with telescope.

local harpoon_setup, harpoon = pcall(require, "harpoon")
if not harpoon_setup then return end

--Configure harpoon.
harpoon.setup({
	menu = {
		width = vim.api.nvim_win_get_width(0) - 4,
	}
})

--Registering harpoon commands here as actions so they can be called less messily in keymap.lua.
vim.api.nvim_create_user_command("HarpoonAddMark", function() require("harpoon.mark").add_file() end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonQuickMenu", function() require("harpoon.ui").toggle_quick_menu() end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav1", function() require("harpoon.ui").nav_file(1) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav2", function() require("harpoon.ui").nav_file(2) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav3", function() require("harpoon.ui").nav_file(3) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav4", function() require("harpoon.ui").nav_file(4) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav5", function() require("harpoon.ui").nav_file(5) end, {nargs = 0})
vim.api.nvim_create_user_command("HarpoonNav6", function() require("harpoon.ui").nav_file(6) end, {nargs = 0})
