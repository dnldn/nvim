--This file contains all lsp servers to be called.
local m = {}
function m.init()

	--TODO: Opts objects should be called from a settings files.

	--Lua proof-reading.
	require("lspconfig").sumneko_lua.setup{}

end

return m
