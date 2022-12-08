vim.api.nvim_create_user_command("Sublime",
function ()

	--Declare local object for commands/methods.
	local m = {}

	--Assign getter methods here. Compress to single line after unit testing.
	function m._1() return "w" end
	function m._2() m.row, m.col = unpack(vim.api.nvim_win_get_cursor(0)) m.buffer = vim.api.nvim_buf_get_name(0) return ".!subl -a " .. m.buffer .. ":" .. m.row .. ":" .. m.col+1 end
	function m._3() return "u" end

	--Declare command strings.
	m[1] = m._1() --Save.
	m[2] = m._2() --Open sublime to current buffer/position in VIM.
	m[3] = m._3() --Undo to clean up.

	--Execute commands in sequence.
	for i = 1, #m do vim.api.nvim_command(m[i]) end
end, {nargs = 0})
