**Contains required statements of any option that must be explicitly called (my own customizations/anything not done automatically in rtp).
init.lua 

**Contains globally-initialized files. Files are initialized, checked for errors, checked for updates.
lua/user 
	
**Contains configuration files for existing plugins. Files here are loaded after everything has been initialized.
after/plugin

**Contains user lua scripts that are run as commands.
lua/user/commands

**Contains lsp/formatting/linters/autocomplete settings and initializations.
lua/user/lsp

