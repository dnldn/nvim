vim.api.nvim_create_user_command("DeleteAllMarksFromBuffer",
function ()

	--Declare local object for commands/methods.
	local m = {}

	--Assign getter methods here. Compress to single line after unit testing.
	function m._1() return "lua require'marks'.delete_buf()" end
	function m._2() return "wshada!" end

	--Declare command strings.
	m[1] = m._1() --Toggle command on or off, and return boolean.
	m[2] = m._2() --Echo toggle state of LSP diagnostics and update keymaps.

	--Execute commands in sequence.
	for i = 1, #m do vim.api.nvim_command(m[i]) end
end, {nargs = 0})
