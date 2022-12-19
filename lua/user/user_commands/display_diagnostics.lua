vim.api.nvim_create_user_command("DisplayDiagnostics",
function ()

	--Declare local object for commands/methods.
	local m = {}

	--Assign getter methods here. Compress to single line after unit testing.
	function m._1() return "lua DisplayDiagnostics()", not vim.g.lsp_diagnostics_toggled end --Need to return "not" because value doesn't flip until function has been run.
	function m._2(on)
		if on then
			vim.keymap.set("n", "<A-j>", function() vim.diagnostic.goto_next() end, {})
			vim.keymap.set("n", "<A-k>", function() vim.diagnostic.goto_prev() end, {})
			return "echo \"LSP diagnostics have been toggled on.\""
		else
			vim.keymap.set("n", "<A-j>", "<cmd>wincmd j<CR>") --Note: This bind will change depending on whether LSP diagnostics are toggled or not.
			vim.keymap.set("n", "<A-k>", "<cmd>wincmd k<CR>") --Note: This bind will change depending on whether LSP diagnostics are toggled or not.
			return "echo \"LSP diagnostics have been toggled off.\""
		end
	end

	--Declare command strings.
	m[1], m.state  = m._1() --Toggle command on or off, and return boolean.
	m[2] = m._2(m.state) --Echo toggle state of LSP diagnostics and update keymaps.

	--Execute commands in sequence.
	for i = 1, #m do vim.api.nvim_command(m[i]) end
end, {nargs = 0})
