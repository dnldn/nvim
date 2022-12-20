--Registering plugins if valid.
local function register(name, opts) local valid, _ = pcall(require, name) if not valid then return else require(name).setup(opts) end end

--Implementing lualine  for status bar.
register("lualine", {})

--Implementing devicons for neat little emojis.
register("nvim-web-devicons", {})

--Implementing status bar for when LSP resources are loading.
-- register("fidget", {})
require"fidget".setup{}
