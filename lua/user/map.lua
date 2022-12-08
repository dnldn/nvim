--This file gets called by keymap.lua.
local m = {}

local function bind(op, outer_opts)
	outer_opts = outer_opts or {noremap = true}
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts, opts or {})
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

--Binding for each mode.
m.nmap = bind("n", {noremap = false})
m.nnoremap = bind("n")
m.vnoremap = bind("v")
m.xnoremap = bind("x")
m.inoremap = bind("i")
return m
