--Require all user commands in directory. Commenting a line out will disable without breaking keymap.lua.
local m = {}
require("user.user_commands.sublime") m.sublime = true
require("user.user_commands.toggle_cmp") m.toggle_cmp = true
require("user.user_commands.darkmode") m.darkmode = true
require("user.user_commands.display_diagnostics_coc") m.diagnostics = true
require("user.user_commands.delete_mark_from_buffer") m.delmark = true
require("user.user_commands.delete_all_marks_from_buffer") m.delmarks = true
return m


--Unused/deprecated:
-- require("user.user_commands.display_diagnostics_lsp") m.diagnostics = true
