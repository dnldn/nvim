--This file can be loaded by calling 'lua require ('plugins') from your init.vim.

--Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	--Visual plugins.
	use 'folke/tokyonight.nvim'
	use "nvim-lualine/lualine.nvim"
	use 'nvim-tree/nvim-web-devicons'
	use 'j-hui/fidget.nvim'

	--Command/movement plugins.
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-abolish'
	use { 'phaazon/hop.nvim', branch = 'v2', config = function() require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' } end }

	--Navigation plugins.
	use { 'ThePrimeagen/harpoon' }
	use { 'nvim-tree/nvim-tree.lua', tag = 'nightly' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }
	use 'chentoast/marks.nvim'


	--Reverting back to using lsp-zero instead of going a la carte. Too much configuration to manage the way I had it.
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
	use {'neoclide/coc.nvim', branch = 'release'}


	--Utility plugins.
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-fugitive'
	use 'RishabhRD/popfix'
	use 'RishabhRD/nvim-cheat.sh'
	-- use 'ojroques/nvim-osc52'

	--TODO: compress and remove redundant dependency after unit testing.
	use({
		"jackMort/ChatGPT.nvim",
		config = function()
		require("chatgpt").setup({ --[[ optional configuration ]]}) end,
		requires = {
			"MunifTanjim/nui.nvim",
			-- "nvim-lua/plenary.nvim",
			-- "nvim-telescope/telescope.nvim"
		    }
	})


	--Disabling this to try out coc.
	--[[
	use {
		'VonHeikemen/lsp-zero.nvim',
		 requires = {
		 	-- LSP Support
		 	{'neovim/nvim-lspconfig'},
		 	{'williamboman/mason.nvim'},
		 	{'williamboman/mason-lspconfig.nvim'},

		 	-- Autocompletion
		 	{'hrsh7th/nvim-cmp'},
		 	{'hrsh7th/cmp-buffer'},
		 	{'hrsh7th/cmp-path'},
			{'hrsh7th/cmp-cmdline'},
		 	{'saadparwaiz1/cmp_luasnip'},
		 	{'hrsh7th/cmp-nvim-lsp'},
		 	{'hrsh7th/cmp-nvim-lua'},

		 	-- Snippets
		 	{'L3MON4D3/LuaSnip'},
		 	{'rafamadriz/friendly-snippets'},
		 }
	}
	]]

end)
