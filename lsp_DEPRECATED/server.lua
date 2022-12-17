--This file contains all lsp servers to be called. Configurations are in config subfolder.
local m = {}
function m.init()

	--Lua proof-reading. Contains recognitiion for vim globals.
	require("user.lsp.config.lua_lsp").init()

end
return m
