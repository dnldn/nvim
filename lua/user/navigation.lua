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


--Importing telescope: TODO - refactor with local function register.
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then return end

--Importing telescope actions. Refactor here as well.
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then return end

-- configure telescope
telescope.setup({
  -- configure custom mappings
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})

--Extension with improved fuzzy find performance.
telescope.load_extension("fzf")
