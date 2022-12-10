--This file can be loaded by calling 'lua require ('plugins') from your init.vim.

--Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

--Collapse all plugins to one line once added. Run :so to source, then PackerSync
return require('packer').startup(function(use)

	--Visual plugins.
	use 'folke/tokyonight.nvim'
	use "nvim-lualine/lualine.nvim"
	use 'nvim-tree/nvim-web-devicons'

	--Utility plugins.
	use 'wbthomason/packer.nvim'
	use 'tpope/vim-fugitive'

	--Command/movement plugins.
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use { 'phaazon/hop.nvim', branch = 'v2', config = function() require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' } end }

	--Managing LSP/Linters/DAP/formatters.
	use 'williamboman/mason.nvim'
	use 'williamboman/mason-lspconfig'
	use 'neovim/nvim-lspconfig'

	--Completion engine.
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use 'hrsh7th/nvim-cmp'

	--Snippets.
	use 'L3Mon4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'
	use 'rafamadriz/friendly-snippets'

	--Navigation plugins.
	use { 'ThePrimeagen/harpoon' }
	use { 'nvim-tree/nvim-tree.lua', tag = 'nightly' }
	use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }

end)

