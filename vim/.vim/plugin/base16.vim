" Base16 highlight group customization
" vint: -ProhibitUnnecessaryDoubleQuote
" source: https://www.reddit.com/r/vimporn/comments/ewqdgc/neovim_as_an_ide_with_no_clutter_at_all
" Format: function! g:Base16hi(group, guifg, guibg, ctermfg, ctermbg, ...)

function! s:base16_customize() abort
  call Base16hi("ColorColumn", "", g:base16_gui01, "", g:base16_cterm01, "", "")
  " disable custom cursorline since vimrc controls it
  " call Base16hi("CursorLine", "", g:base16_gui02, "", g:base16_cterm02, "", "")
  " this overrides the cursorline to have no background
  call Base16hi("CursorLine", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  " the following line removes an underline from the line number
  call Base16hi("CursorLineNr", "", g:base16_gui02, "", g:base16_cterm02, "bold", "")
  call Base16hi("Pmenu", "", g:base16_gui02, "", g:base16_cterm02, "", "")
  call Base16hi("FoldColumn", "", g:base16_gui01, "", g:base16_cterm00, "", "")
  call Base16hi("Folded",  "", g:base16_gui01, "", g:base16_cterm00, "", "")
  call Base16hi("SignColumn", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("VertSplit", g:base16_gui01, g:base16_gui00, g:base16_cterm00, g:base16_cterm00, "", "")
  call Base16hi("DiffAdd", g:base16_gui00, g:base16_gui0B, "", g:base16_cterm00, "", "")
  call Base16hi("DiffDelete", g:base16_gui08, g:base16_gui08, "", g:base16_cterm00, "", "")
  call Base16hi("DiffChange", g:base16_gui00, g:base16_gui04, "", g:base16_cterm00, "", "")
  call Base16hi("DiffText", g:base16_gui0D, g:base16_gui04, "", g:base16_cterm00, "", "")
  call Base16hi("LineNr", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("Cursor", "", "", "", "", "inverse", "")
  call Base16hi("htmlBold", g:base16_gui05, "", g:base16_cterm05, "", "bold", "")
  call Base16hi("htmlItalic", g:base16_gui05, "", g:base16_cterm05, "", "italic", "")
  call Base16hi("Italic", "", "", "", "", "italic", "")
  " call Base16hi("Comment", "", "", "", "", "italic", "")
  call Base16hi("StatusLineNC", "", g:base16_gui01, "", g:base16_cterm01, "", "")
  call Base16hi("StatusLine", "", g:base16_gui01, "", g:base16_cterm01, "", "")
endfunction

augroup on_change_colorscheme
  autocmd!
  autocmd ColorScheme * call s:base16_customize()
augroup END

" Load the colorscheme that was set from base16-shell
if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

" fixes for highlight groups
hi! ALEErrorSign ctermbg=NONE ctermfg=red
hi! ALEWarningSign ctermbg=NONE ctermfg=yellow
hi! link SignifySignAdd DiffAdded
hi! link SignifySignChange DiffLine
hi! link SignifySignDelete DiffRemoved
