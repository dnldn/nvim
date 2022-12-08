--This file can be loaded by calling 'lua require ('plugins') from your init.vim.

--Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

--Collapse all plugins to one line once added. Run :so to source, then PackerSync
return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'
	use 'folke/tokyonight.nvim'
	use 'tpope/vim-surround'
	use 'tpope/vim-commentary'
	use 'tpope/vim-fugitive'

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

	use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons', }, tag = 'nightly' }
	use { 'nvim-telescope/telescope.nvim', tag = '0.1.0', requires = { {'nvim-lua/plenary.nvim'} } }
	use { 'phaazon/hop.nvim', branch = 'v2', config = function() require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' } end }
end)

