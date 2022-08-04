"==============================================================================
" Base16 highlight group customization
"==============================================================================
function! s:base16_customize() abort
  " Usage: call Base16hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  " source: https://www.reddit.com/r/vimporn/comments/ewqdgc/neovim_as_an_ide_with_no_clutter_at_all

  " custom highlight groups used in _statusline.vim
  call Base16hi('StatusLineWhite',   g:base16_gui05, g:base16_gui01, g:base16_cterm02, g:base16_cterm01, '', '')
  call Base16hi('StatusLineRed',     g:base16_gui08, g:base16_gui01, g:base16_cterm08, g:base16_cterm01, '', '')
  call Base16hi('StatusLineOrange',  g:base16_gui09, g:base16_gui01, g:base16_cterm09, g:base16_cterm01, '', '')
  call Base16hi('StatusLineYellow',  g:base16_gui0A, g:base16_gui01, g:base16_cterm0A, g:base16_cterm01, '', '')
  call Base16hi('StatusLineGreen',   g:base16_gui0B, g:base16_gui01, g:base16_cterm0B, g:base16_cterm01, '', '')
  call Base16hi('StatusLineCyan',    g:base16_gui0C, g:base16_gui01, g:base16_cterm0C, g:base16_cterm01, '', '')
  call Base16hi('StatusLineBlue',    g:base16_gui0D, g:base16_gui01, g:base16_cterm0D, g:base16_cterm01, '', '')
  call Base16hi('StatusLineMagenta', g:base16_gui0E, g:base16_gui01, g:base16_cterm0E, g:base16_cterm01, '', '')

  " call Base16hi('ColorColumn', '', g:base16_gui01, '', g:base16_cterm01, '', '')
  " call Base16hi('Comment', '', '', '', '', 'italic', '')
  " remove an underline from the line number
  " call Base16hi('Cursor', '', '', '', '', 'inverse', '')
  " overrides the cursorline to have no background
  " call Base16hi('CursorLine', '', g:base16_gui00, '', g:base16_cterm00, '', '')
  " call Base16hi('CursorLineNr', '','', '','', 'bold', '')
  " call Base16hi('DiffAdd', g:base16_gui00, g:base16_gui0B, '', g:base16_cterm00, '', '')
  " call Base16hi('DiffChange', g:base16_gui00, g:base16_gui04, '', g:base16_cterm00, '', '')
  " call Base16hi('DiffDelete', g:base16_gui08, g:base16_gui08, '', g:base16_cterm00, '', '')
  " call Base16hi('DiffText', g:base16_gui0D, g:base16_gui04, '', g:base16_cterm00, '', '')
  " call Base16hi('FoldColumn', '', g:base16_gui01, '', g:base16_cterm00, '', '')
  " call Base16hi('Folded',  '', g:base16_gui01, '', g:base16_cterm00, '', '')
  " call Base16hi('Italic', '', '', '', '', 'italic', '')
  " call Base16hi('LineNr', '', g:base16_gui00, '', g:base16_cterm00, '', '')
  " call Base16hi('Pmenu', '', g:base16_gui02, '', g:base16_cterm02, '', '')
  " call Base16hi('SignColumn', '', g:base16_gui00, '', g:base16_cterm00, '', '')
  " call Base16hi('StatusLine', '', g:base16_gui01, '', g:base16_cterm01, '', '')
  " call Base16hi('StatusLineNC', '', g:base16_gui01, '', g:base16_cterm01, '', '')
  " call Base16hi('VertSplit', g:base16_gui01, g:base16_gui00, g:base16_cterm00, g:base16_cterm00, '', '')
  " call Base16hi('htmlBold', g:base16_gui05, '', g:base16_cterm05, '', 'bold', '')
  " call Base16hi('htmlItalic', g:base16_gui05, '', g:base16_cterm05, '', 'italic', '')
  " call Base16hi('CocErrorSign', g:base16_gui08, '', g:base16_cterm08, '', '', '')
  " call Base16hi('CocWarningSign', g:base16_gui09, '', g:base16_cterm09, '', '', '')
endfunction

"==============================================================================
" Colorscheme
"------------------------------------------------------------------------------
augroup OnChangeColorscheme
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" Load the colorscheme that was set by base16-shell
if exists('$BASE16_THEME')
      \ && (!exists('g:colors_name')
      \ || g:colors_name != 'base16-$BASE16_THEME')
  colorscheme base16-$BASE16_THEME
endif

"==============================================================================
" Highlight group overrides
"------------------------------------------------------------------------------
" Use better colors for CoC
hi! link CocDiffAdd         DiffAdded
hi! link CocDiffChange      DiffLine
hi! link CocDiffDelete      DiffRemoved
hi! link CocErrorHighlight  Underlined

" Make folds more visible
hi! link Folded             StatusLineNC

" Remove the background and underline from the cursor line
hi! CursorLine              ctermbg=NONE guibg=NONE

" Remove bold from the cursor line number
hi! CursorLineNr            cterm=NONE
