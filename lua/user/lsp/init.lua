local plugin = require("user.lsp.plugin")
local server = require("user.lsp.server")
local auto = require("user.lsp.auto")
local snippet = require("user.lsp.lua_snippets")

--Initializing all management plugins - mason, lsp-nvim etc.
plugin.init()

--Initializing LSP servers.
server.init()

--Initializing auto-complete engine/snippets.
auto.init()

--Initializing individual snippets.
snippet.init()
