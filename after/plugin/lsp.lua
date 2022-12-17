local lsp = require("lsp-zero")

lsp.preset("recommended")

lsp.ensure_installed({
  'tsserver',
  'eslint',
  'sumneko_lua',
  'rust_analyzer',
})

--Used to define tab behavior in autocomplete keybinds.
local luasnip = require('luasnip')
local check_back_space = function() local col = vim.fn.col('.') - 1 if col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then return true else return false end end

local cmp = require('cmp')
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

	--Goes to next or previous diagnostic error.
	vim.keymap.set("n", "<A-J>", function() vim.diagnostic.goto_next() end, opts)
	vim.keymap.set("n", "<A-K>", function() vim.diagnostic.goto_prev() end, opts)

	--Be VERY careful with this one - performs project-wide renaming of functions/variables. Doesn't always work for some unknown reason (does not work on this current file lsp.lua)
	vim.keymap.set("n", "<F6><F6>", function() vim.lsp.buf.rename() end, opts)

	--Calls up code actions on a diagnostic line - doesn't tend to have useful suggestions.
	vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end, opts)

	--Orphaned actions/ones I can't find a use for.

	-- Doesn't seem to do anything without arguments, but I would like a way to toggle aggressive highlighting on and off.
	-- vim.keymap.set("n", "<leader>sd", function() vim.diagnostic.show() end, opts)

	--Lists references for character under cursor in quick fix menu. Not even really usign quick fix menu yet, so... ehh.
	-- vim.keymap.set("n", "<leader>qr", function() vim.lsp.buf.references() end, opts)

	--This seems to do a text search through the entire directory and all vim resources... struggling to think of a use case here when I have ripgrep and it's faster.
	-- vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)

end)

lsp.setup()
