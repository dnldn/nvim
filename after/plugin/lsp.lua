--TODO: Disabled while testing out coc.nvim
--[[
--FIXME: only lua is initializing properly on buffer startup - shell, java and others do not initialize properly.
local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
})

	--TODO: this may no loner be needed - disable it an see if any issues come up.
	--local util = require("lspconfig/util")
	--require("lspconfig").sumneko_lua.setup{
	--	on_attach = custom_attach,
	--	root_dir = function(fname) return util.find_git_ancestor(fname) or util.path.dirname(fname) end,
	--	settings = {
	--		Lua = {

	--			--Tell the language server which version of Lua you're using, and set up lua path.
	--			runtime = { version = 'LuaJIT', path = vim.split(package.path, ';'), },

	--			-- Get the language server to recognize the `vim` global
	--			diagnostics = { globals = {'vim'}, },

	--			-- Make the server aware of Neovim runtime files
	--			workspace = { library = { [vim.fn.expand('$VIMRUNTIME/lua')] = true, [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true, },

	--			},
	--		},
	--	},
	--}

--Used to define tab behavior in autocomplete keybinds.
local luasnip = require('luasnip')
local check_back_space = function() local col = vim.fn.col('.') - 1 if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then return true else return false end end

--Requiring cmp to add bindings/cmp toggling ability. vim.g.nvim_cmp_toggle is the global toggle variable.
local cmp = require('cmp')
vim.g.nvim_cmp_toggle = true
cmp.setup { enabled = function() return vim.g.nvim_cmp_toggle end }


--Attempting to initialize reaper snippets.
require("luasnip.loaders.from_snipmate").lazy_load({paths = "./snippets/"})
require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

local cmp_select = {behavior = cmp.SelectBehavior.Select}
local cmp_mappings = lsp.defaults.cmp_mappings({
	["<C-p>"] = cmp.mapping.scroll_docs(-4), --Doesn't work very consistently, but useful on ./
	["<C-n>"] = cmp.mapping.scroll_docs(4),  --Doesn't work very consistently, but useful on ./
	['<C-e>'] = cmp.mapping.abort(),
	['<C-j>'] = cmp.mapping.select_next_item(),
	['<C-k>'] = cmp.mapping.select_prev_item(),

	-- Tab will select the current menu option, or tab between placeholder arguments if they are jumpable within the current snippet. Shift tab will jump backwards.
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
})

lsp.set_preferences({
  sign_icons = { error = 'X',
    warn = 'W',
    hint = 'H',
    info = '?'}
})

lsp.setup_nvim_cmp({
  mapping = cmp_mappings
})

--On attach: happens on every single buffer that has an LSP associated with it. That makes these remaps only exist for the current buffer you're on.
lsp.on_attach(function(client, bufnr)
	local opts = {buffer = bufnr, remap = false}

	--Goes to definition.
	vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)

	--Displays hover prompt, displaying arguments and returns. Note: any comment directly above a function (at least in lua) will be read. Try it below.
	vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)

	--Finds all references to function in project directory. Searches out of directory for vim API files.
	vim.keymap.set("n", "gr", function() vim.lsp.buf.references() end, opts)

	--Be VERY careful with this one - performs project-wide renaming of functions/variables. Doesn't always work for some unknown reason (does not work on this current file lsp.lua)
	vim.keymap.set("n", "<F6><F6>", function() vim.lsp.buf.rename() end, opts)

	--Calls up code actions on a diagnostic line - doesn't tend to have useful suggestions.
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)

	--Orphaned actions/ones I can't find a use for.
		--Kept for reference - alt-j and alt-k handle diagnostic navigation only when diagnostics are toggled by alt-d. (lua/user/user_commands/display_diagnostics.lua)
			--vim.keymap.set("n", "<A-j>", function() vim.diagnostic.goto_next() end, opts)
			--vim.keymap.set("n", "<A-k>", function() vim.diagnostic.goto_prev() end, opts)
		-- Doesn't seem to do anything without arguments, but I would like a way to toggle aggressive highlighting on and off.
			--vim.keymap.set("n", "<leader>sd", function() vim.diagnostic.show() end, opts)
		--Lists references for character under cursor in quick fix menu. Not even really usign quick fix menu yet, so... ehh.
			--vim.keymap.set("n", "<leader>qr", function() vim.lsp.buf.references() end, opts)
		--This seems to do a text search through the entire directory and all vim resources... struggling to think of a use case here when I have ripgrep and it's faster.
			--vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

end)

lsp.setup()

--Global variable - toggles LSP diagnostic display.
vim.g.lsp_diagnostics_toggled = false

--Global function to enable/disable LSP diagnostics (must be called after lsp.setup()).
function DisplayDiagnosticsLsp()
	if not vim.g.lsp_diagnostics_toggled then
		vim.diagnostic.config({ virtual_text = true, underline = true, })
		vim.g.lsp_diagnostics_toggled = true
	else
		vim.diagnostic.config({ virtual_text = false, underline = false, })
		vim.g.lsp_diagnostics_toggled = false
	end
end
]]
