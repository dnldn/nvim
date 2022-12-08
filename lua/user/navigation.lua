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


--TODO: reserved for telescope bindings.
