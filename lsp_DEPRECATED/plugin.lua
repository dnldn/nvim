local m = {}

--Register plugin if it is valid.
function m.register(name, opts)
	local valid, _ = pcall(require, name) if not valid then return else require(name).setup(opts) end
end

function m.init()

	local mason = {title="mason", opts = {}}
	local lspconfig = {title="nvim-lspconfig", opts = {}}

	--Require mason and mason lsp config - these manage our LSP, DAT, Linters, and formatters.
	m.register(mason.title, mason.opts)
	m.register(lspconfig, lspconfig.opts)
end

return m
