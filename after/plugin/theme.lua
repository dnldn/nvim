--Tokyo night theme.
vim.cmd("colorscheme tokyonight-moon")
_DarkMode = false

--Global function to enable darker background with less contrast.
function DarkMode()
	if not _DarkMode then
		require("tokyonight").setup({
			on_colors = function(colors)
				colors.bg = "#000000"
				colors.bg_dark = "#000000"
				colors.bg_float = "#000000"
				colors.bg_popup = "#020504"
				colors.bg_sidebar = "#020504"
				colors.bg_statusline = "#020504"
				colors.comment = "#7a88cf"
				colors.fg = "#c8d3f5"
			end
		})
		vim.cmd("colorscheme tokyonight-moon")
		_DarkMode = true
	else
		require("tokyonight").setup({
			on_colors = function(colors)
				colors.bg = "#222436"
				colors.bg_dark = "#1e2030"
				colors.bg_float = "#1e2030"
				colors.bg_popup = "#1e2030"
				colors.bg_sidebar = "#1e2030"
				colors.bg_statusline = "#1e2030"
				colors.comment = "#7a88cf"
				colors.fg = "#c8d3f5"
			end
		})
		vim.cmd("colorscheme tokyonight-moon")
		_DarkMode = false
	end
	return _DarkMode
end

--Color settings for nvim-tree.
vim.opt.termguicolors = true
