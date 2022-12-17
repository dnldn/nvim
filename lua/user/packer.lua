--This file can be loaded by calling 'lua require ('plugins') from your init.vim.

--Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)

	--Visual plugins.
	use 'folke/tokyonight.nvim'
	use "nvim-lualine/lualine.nvim"
	use 'nvim-tree/nvim-web-devicons'

	--Utility plugins.
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-fugitive'
	use 'RishabhRD/popfix'
	use 'RishabhRD/nvim-cheat.sh'

	--Command/movement plugins.
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use { 'phaazon/hop.nvim', branch = 'v2', config = function() require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' } end }

	--Old LSP loading approach:
	--[[
	--Managing LSP/Linters/DAP/formatters.
	-- use 'williamboman/mason.nvim' 							YES
	-- use 'williamboman/mason-lspconfig' 							YES
	-- use 'neovim/nvim-lspconfig' 								YES
	-- use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'} 				YES

	--Completion engine.
	--use 'hrsh7th/cmp-nvim-lsp' 								YES
	--use 'hrsh7th/cmp-buffer' 								YES
	--use 'hrsh7th/cmp-path' 								YES
	--use 'hrsh7th/cmp-cmdline' 								YES
	--use 'hrsh7th/nvim-cmp' 								YES
	--use 'hrsh7th/cmp-nvim-lua' 								YES

	--Snippets.
	--use 'L3Mon4D3/LuaSnip' 								YES
	--use 'saadparwaiz1/cmp_luasnip' 							YES
	--use 'rafamadriz/friendly-snippets' 							YES
	]]

	--Navigation plugins.
	use { 'ThePrimeagen/harpoon' }
	use { 'nvim-tree/nvim-tree.lua', tag = 'nightly' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }

	--Reverting back to using lsp-zero instead of going a la carte. Too much configuration to manage the way I had it.
	use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}


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

end)
