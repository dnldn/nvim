<h1>Neovim configuration.</h1>

All plugins are managed with packer.lua.

**init.lua**: Initializes any files not automatically initialized by Neovim.

**lua/user**: Files initialized at Neovim startup.
- global_options.lua: Change default global VIM settings for indentation, cursor appearance etc.
- keymap.lua: Set global keybindings for default actions and user commands.
- navigation.lua: Settings for nvim-tree, telescope, harpoon, and marks.
- packer.lua: Manages all installed plugins.
- visual_settings: Manage themes, icons and visual flair.
- user_commands: Contains user macros that use vim command line. Initializations are done by all.lua file.

**after/plugin**: Changes settings after contents of lua/user have been initialized.
- lsp.lua: Contains all LSP/autocomplete settings- managed by lsp-zero.
- theme.lua: Initializes themes/user functions loaded by visual_settings.
- treesitter.lua: Manages treesitter plugin.
