local m = {}

--A little messy, but luasnip things need to be called within same block as cmp due to interdependencies.
function m.init_completion_engine()

	--Importing code from nvim-cmp and luasnips.
	local cmp = require('cmp')
	local luasnip = require('luasnip')
	local check_back_space = function() local col = vim.fn.col('.') - 1 if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then return true else return false end end 

	--Messy, but this is the best place to declare this global. This allows autocomplete to be toggled by user command.
	vim.g.nvim_cmp_toggle = true

	--Initialize setup object.
	cmp.setup({

	--Added toggling variable - not strictly necessary to declare it this way, but may implement memory function for autocomplete in the future.
	enabled = function() return vim.g.nvim_cmp_toggle end,

	--Selecting snippet engine.
	snippet = {

	--Initializing snippet engine within CMP block.
	expand = function(args)
		require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
		require("luasnip.loaders.from_vscode").lazy_load()
	end,
	},

	--This changes appearance of completion window. Unchanged from default.
	window = {
	-- completion = cmp.config.window.bordered(),
	-- documentation = cmp.config.window.bordered(),
	},

	--Changing keymappings - fairly self-explanatory from function names.
	mapping = cmp.mapping.preset.insert({
	["<C-b>"] = cmp.mapping.scroll_docs(-4), --Doesn't work very consistently, but useful on ./
	["<C-f>"] = cmp.mapping.scroll_docs(4),  --Doesn't work very consistently, but useful on ./
	['<C-e>'] = cmp.mapping.abort(),
	['<C-j>'] = cmp.mapping.select_next_item(),
	['<C-k>'] = cmp.mapping.select_prev_item(),

	-- Tab will select the current menu option, or tab between placeholder arguments if they are jumpable within the current snippet. Shift tab will jump backwards.
	-- TODO: Occasionally get screwy results when this collides with other processes that require tabbing; ie telescope/nvim-tree.
	['<Tab>'] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.confirm({select = true})
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif check_back_space() then
				fallback()
			else
				cmp.complete()
			end
	end, {'i', 's'}),
	['<S-Tab>'] = cmp.mapping(function() luasnip.jump(-1) end, {'i', 's'}),
	['<CR>'] = cmp.mapping.confirm({ select = true }),
	}),

	--Getting current sources.
	sources = cmp.config.sources({
	{ name = 'nvim_lsp' },
	{ name = 'luasnip' }, -- For luasnip users.
	{ name = 'path' },
	}, {
	{ name = 'buffer' },
	})
	})

	-- Set configuration for specific filetype.
	cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
	{ name = 'cmp_git' }, -- You can specify the `cmp_git` source if you installed it.
	}, {
	{ name = 'buffer' },
	})
	})

	-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
	{ name = 'buffer' }
	}
	})

	-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
	cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
	{ name = 'path' }
	}, {
	{ name = 'cmdline' }
	})
	})

	-- Set up lspconfig.
	local capabilities = require('cmp_nvim_lsp').default_capabilities()
	-- Replace <YOUR_LSP_SERVER> with each lsp server you've enabled.
	require('lspconfig')['<YOUR_LSP_SERVER>'].setup {
	capabilities = capabilities
	}
end

function m.init()
	m.init_completion_engine()
end

return m
