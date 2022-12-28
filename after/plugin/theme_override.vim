function! HighlightOverride() abort
	" highlight CocInfoSign cterm=NONE gui=NONE guifg=#FFFFFF guibg=#000000
	highlight CocInlayHintParameter cterm=NONE gui=NONE guifg=#e117da
endfunction

augroup MyColors
	autocmd!
	autocmd ColorScheme * call HighlightOverride()
augroup END

colorscheme tokyonight-moon
