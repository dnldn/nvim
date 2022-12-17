--TODO: Scope is a little unclear here- proposed change it to "syntax" or "language" or something that includes highlighting, linting, formatting, lsp, autocomplete etc.

--Shouldn't be initialized at current position, but disabling everything below as a safety.
--[[

local plugin = require("user.lsp.plugin")
local server = require("user.lsp.server")
local auto = require("user.lsp.auto")
local snippet = require("user.lsp.lua_snippets")
local highlighting = require("user.lsp.highlighting")


--Initializing all management plugins - mason, lsp-nvim etc.
plugin.init()

--Initializing LSP servers.
server.init()

--Initializing auto-complete engine/snippets.
auto.init()

--Initializing individual snippets.
snippet.init()

--Initializing treesitter.
highlighting.init()
]]
