--Global vim settings.
require("user.global_options")
--Key bindings (note: key bindings within plugins are contained in their respective files.
require("user.keymap")
--Navigation-related settings.
require("user.navigation")
--LSP/autocomplete settings. Source the init.lua file because it's pointed to a directory.
require("user.lsp")

