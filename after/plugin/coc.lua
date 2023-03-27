-- Using this as a guide:
-- https://github.com/sabah1994/dotfiles/blob/master/nvim/lua/plug-config/coc.lua#L39

-- Table value necessary to run vim command script. Vim command script is used because CoC engine doesn't run on lua, so it's a bit of a duct tape job getting access to the methods.
local expr_opts = { noremap = true, silent = true, expr = true }
local opts = { noremap = true, silent = true }

--Tab will confirm current selection on autocomplete.
vim.api.nvim_set_keymap( "i", "<Tab>", [[coc#pum#visible() ? coc#pum#confirm() : "<Tab>"]], expr_opts)

--Ctrl-j and ctrl-k will jump through both autocomplete list and jump parameters.
vim.api.nvim_set_keymap( "i", "<c-j>", [[coc#pum#visible() ? coc#pum#next(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetNext', [])<cr>" : "\<c-j>"]] , expr_opts)
vim.api.nvim_set_keymap( "i", "<c-k>", [[coc#pum#visible() ? coc#pum#prev(1) : coc#jumpable() ? "\<c-r>=coc#rpc#request('snippetPrev', [])<cr>" : "\<c-k>"]] , expr_opts)

--Ganking and seeing what's useful/works.
vim.api.nvim_set_keymap("n", "<leader>gd", "<Plug>(coc-definition)", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>gp", ":call CocAction('jumpDefinition', 'vsplit') <CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>gr", "<Plug>(coc-references)", { silent = true })

--Global function - migrate this to user commands later, testing first. "K" will show either vim, CoC/LSP, or ? keyword information.
function ShowDocumentation()
	local f = vim.bo.filetype
	local c = vim.fn.expand("<cword>")
	if f == "vim" or f == "help" then
		vim.api.nvim_command("h " .. c)
	elseif vim.fn["coc#rpc#ready"]() then
		vim.fn.CocActionAsync("doHover")
	else
		vim.api.nvim_command( "!" .. vim.bo.keywordprg .. " " .. c)
	end
end

--This one works fine.
vim.api.nvim_set_keymap("n", "K", ":lua ShowDocumentation() <CR>", opts)

--Display diagnostics in a console window below.
vim.api.nvim_set_keymap("n", "<leader>dc", ":<C-u>CocList diagnostics<CR>", opts)

--Global variable for toggling Coc diagnostics.
vim.g.diagnostics_toggled = true
function DisplayDiagnosticsCoc()
	if not vim.g.diagnostics_toggled then
		vim.api.nvim_command("CocEnable")
		vim.g.diagnostics_toggled = true
	else
		vim.api.nvim_command("CocDisable")
		vim.g.diagnostics_toggled = false
	end
end

--Global function to navigate diagnostics or windows depending on context. Migrate to user functions later. TODO
function NavigateWindowsOrDiagnosticsUp()
	if #vim.api.nvim_list_wins() == 1 then
		vim.api.nvim_command("call CocActionAsync('diagnosticPrevious')")
	else
		vim.api.nvim_command("wincmd k")
	end
end

--Global function to navigate diagnostics or windows depending on context. Migrate to user functions later. TODO
function NavigateWindowsOrDiagnosticsDown()
	if #vim.api.nvim_list_wins() == 1 then
		vim.api.nvim_command("call CocActionAsync('diagnosticNext')")
	else
		vim.api.nvim_command("wincmd j")
	end
end

vim.api.nvim_set_keymap("n", "<A-k>", ":lua NavigateWindowsOrDiagnosticsUp()<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-j>", ":lua NavigateWindowsOrDiagnosticsDown()<CR>", { silent = true })

--Toggles inlay hints. This is fun to type, so I don't mind doing it separate from diagnostics.
vim.api.nvim_set_keymap("n", "<leader>ih", ":CocCommand document.toggleInlayHint<CR>", opts)

--Refactor command - big yikes on this one, it skips commented out references?
--It also isn't giving printout of (x changes in y files), or providing undo when you use it... yeah, super dangerous.
--You can check that after renaming with CocCommand workspace.inspectEdit, but I'm going to have difficulty chaining that I think.
--The comment thing is super dangerous too. Makes me not trust it to properly assess when something is in a function or string too.
--https://github.com/neoclide/coc.nvim/issues/954 - looks like it kicks back to language server for rename features, and will only target current buffer if no rename feature is found.
--TODO: Implement a readout/saveall system.
vim.api.nvim_set_keymap("n", "<F6><F6>", "<Plug>(coc-rename)", { silent = false })
