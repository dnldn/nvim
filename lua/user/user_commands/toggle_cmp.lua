vim.api.nvim_create_user_command("CmpToggle",
function ()

	--Declare local object for commands/methods.
	local m = {}

	--Assign getter methods here. Compress to single line after unit testing.
	function m._1() if vim.g.nvim_cmp_toggle == true then return "let g:nvim_cmp_toggle = v:false", false else return "let g:nvim_cmp_toggle = v:true", true end end
	function m._2(on) if on then return "echo \"Autocomplete has been toggled on.\"" else return "echo \"Autocomplete has been toggled off.\"" end end

	--Declare command strings.
	m[1], m.state  = m._1() --Toggle command on or off, and return boolean.
	m[2] = m._2(m.state) --Echo toggle state of autocomplete.

	--Execute commands in sequence.
	for i = 1, #m do vim.api.nvim_command(m[i]) end
end, {nargs = 0})
