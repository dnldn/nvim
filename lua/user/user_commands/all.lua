--Require all user commands in directory. Commenting a line out will disable without breaking remap.lua.
local m = {}
require("user.user_commands.sublime") m.sublime = true
require("user.user_commands.toggle_cmp") m.toggle_cmp = true
return m