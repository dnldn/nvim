--Settings for sumneko lua lsp.
local m = {}
function m.init()
	local util = require("lspconfig/util")
	require("lspconfig").sumneko_lua.setup{
		on_attach = custom_attach,
		root_dir = function(fname) return util.find_git_ancestor(fname) or util.path.dirname(fname) end,
		settings = {
			Lua = {

				--Tell the language server which version of Lua you're using, and set up lua path.
				runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },

				-- Get the language server to recognize the `vim` global
				diagnostics = { globals = {'vim'}, },

				-- Make the server aware of Neovim runtime files
				workspace = { library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true, },

				},
			},
		},
	}
end
return m
