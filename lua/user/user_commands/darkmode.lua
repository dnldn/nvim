vim.api.nvim_create_user_command("DarkMode",
function ()

	--Declare local object for commands/methods.
	local m = {}

	--Assign getter methods here. Compress to single line after unit testing.
	function m._1()
		return "lua DarkMode()"
	end

	--Declare command strings.
	m[1], m.state  = m._1() --Toggle command on or off, and return boolean.

	--Execute commands in sequence.
	for i = 1, #m do vim.api.nvim_command(m[i]) end
end, {nargs = 0})
