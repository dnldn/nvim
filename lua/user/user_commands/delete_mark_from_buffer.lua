vim.api.nvim_create_user_command("DeleteMarkFromBuffer",
function ()

	--Declare local object for commands/methods.
	local m = {}

	--Assign getter methods here. Compress to single line after unit testing.
	function m._1() return "lua require'marks'.delete_line()" end
	function m._2() return "wshada!" end

	--Declare command strings.
	m[1] = m._1() --Delete any existing marks on line.
	m[2] = m._2() --Update shada file so changes become persistent when session is next reloaded.

	--Execute commands in sequence.
	for i = 1, #m do vim.api.nvim_command(m[i]) end
end, {nargs = 0})
