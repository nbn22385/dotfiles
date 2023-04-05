if &runtimepath=~'base16-vim'
"==============================================================================
" Base16 highlight group customization
"==============================================================================
function! s:base16_customize() abort
  " Usage: call Base16hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  call Base16hi('Folded',            g:base16_gui03, g:base16_gui01, g:base16_cterm03, g:base16_cterm01, 'italic', '')
  call Base16hi('StatusLineWhite',   g:base16_gui05, g:base16_gui01, g:base16_cterm02, g:base16_cterm01, '', '')
  call Base16hi('StatusLineRed',     g:base16_gui08, g:base16_gui01, g:base16_cterm08, g:base16_cterm01, '', '')
  call Base16hi('StatusLineOrange',  g:base16_gui09, g:base16_gui01, g:base16_cterm09, g:base16_cterm01, '', '')
  call Base16hi('StatusLineYellow',  g:base16_gui0A, g:base16_gui01, g:base16_cterm0A, g:base16_cterm01, '', '')
  call Base16hi('StatusLineGreen',   g:base16_gui0B, g:base16_gui01, g:base16_cterm0B, g:base16_cterm01, '', '')
  call Base16hi('StatusLineCyan',    g:base16_gui0C, g:base16_gui01, g:base16_cterm0C, g:base16_cterm01, '', '')
  call Base16hi('StatusLineBlue',    g:base16_gui0D, g:base16_gui01, g:base16_cterm0D, g:base16_cterm01, '', '')
  call Base16hi('StatusLineMagenta', g:base16_gui0E, g:base16_gui01, g:base16_cterm0E, g:base16_cterm01, '', '')
endfunction

"==============================================================================
" Colorscheme
"------------------------------------------------------------------------------
augroup OnChangeColorscheme
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" Load the colorscheme that was set by base16-shell
if filereadable(expand("$HOME/.config/tinted-theming/set_theme.vim"))
  source $HOME/.config/tinted-theming/set_theme.vim
endif

"==============================================================================
" Highlight group overrides
"------------------------------------------------------------------------------
" Use better colors for CoC
hi! link CocDiffAdd         DiffAdded
hi! link CocDiffChange      DiffLine
hi! link CocDiffDelete      DiffRemoved
hi! link CocErrorHighlight  Underlined

endif
