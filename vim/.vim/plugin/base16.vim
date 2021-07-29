" colorscheme sonokai
if 1
" Base16 highlight group customization
" vint: -ProhibitUnnecessaryDoubleQuote
" source: https://www.reddit.com/r/vimporn/comments/ewqdgc/neovim_as_an_ide_with_no_clutter_at_all
" Format: function! g:Base16hi(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)

function! s:base16_customize() abort
  call Base16hi("ColorColumn", "", g:base16_gui01, "", g:base16_cterm01, "", "")
  " call Base16hi("Comment", "", "", "", "", "italic", "")
  " remove an underline from the line number
  call Base16hi("Cursor", "", "", "", "", "inverse", "")
  " overrides the cursorline to have no background
  call Base16hi("CursorLine", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("CursorLineNr", "", g:base16_gui02, "", g:base16_cterm02, "bold", "")
  call Base16hi("DiffAdd", g:base16_gui00, g:base16_gui0B, "", g:base16_cterm00, "", "")
  call Base16hi("DiffChange", g:base16_gui00, g:base16_gui04, "", g:base16_cterm00, "", "")
  call Base16hi("DiffDelete", g:base16_gui08, g:base16_gui08, "", g:base16_cterm00, "", "")
  call Base16hi("DiffText", g:base16_gui0D, g:base16_gui04, "", g:base16_cterm00, "", "")
  call Base16hi("FoldColumn", "", g:base16_gui01, "", g:base16_cterm00, "", "")
  call Base16hi("Folded",  "", g:base16_gui01, "", g:base16_cterm00, "", "")
  call Base16hi("Italic", "", "", "", "", "italic", "")
  call Base16hi("LineNr", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("Pmenu", "", g:base16_gui02, "", g:base16_cterm02, "", "")
  call Base16hi("SignColumn", "", g:base16_gui00, "", g:base16_cterm00, "", "")
  call Base16hi("StatusLine", "", g:base16_gui01, "", g:base16_cterm01, "", "")
  call Base16hi("StatusLineNC", "", g:base16_gui01, "", g:base16_cterm01, "", "")
  call Base16hi("VertSplit", g:base16_gui01, g:base16_gui00, g:base16_cterm00, g:base16_cterm00, "", "")
  call Base16hi("htmlBold", g:base16_gui05, "", g:base16_cterm05, "", "bold", "")
  call Base16hi("htmlItalic", g:base16_gui05, "", g:base16_cterm05, "", "italic", "")
  call Base16hi("CocErrorSign", g:base16_gui08, "", g:base16_cterm08, "", "", "")
  call Base16hi("CocWarningSign", g:base16_gui09, "", g:base16_cterm09, "", "", "")
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

highlight! link CocSem_angle Keyword
highlight! link CocSem_annotation Keyword
highlight! link CocSem_attribute Type
highlight! link CocSem_bitwise Keyword
highlight! link CocSem_boolean Boolean
highlight! link CocSem_brace Normal
highlight! link CocSem_bracket Normal
highlight! link CocSem_builtinAttribute Type
highlight! link CocSem_builtinType Type
highlight! link CocSem_character String
highlight! link CocSem_class Type
highlight! link CocSem_colon Normal
highlight! link CocSem_comma Normal
highlight! link CocSem_comment Comment
highlight! link CocSem_comparison Keyword
highlight! link CocSem_constParameter Identifier
highlight! link CocSem_dependent Keyword
highlight! link CocSem_dot Keyword
highlight! link CocSem_enum Structure
highlight! link CocSem_enumMember Identifier
highlight! link CocSem_escapeSequence Type
highlight! link CocSem_event Type
highlight! link CocSem_formatSpecifier Type
highlight! link CocSem_function Function
highlight! link CocSem_interface Type
highlight! link CocSem_keyword Keyword
highlight! link CocSem_label Keyword
highlight! link CocSem_logical Keyword
highlight! link CocSem_macro Macro
highlight! link CocSem_method Function
highlight! link CocSem_modifier Keyword
highlight! link CocSem_namespace Label
highlight! link CocSem_number Number
highlight! link CocSem_operator Keyword
highlight! link CocSem_parameter Identifier
highlight! link CocSem_parenthesis Normal
highlight! link CocSem_property Identifier
highlight! link CocSem_punctuation Keyword
highlight! link CocSem_regexp Type
highlight! link CocSem_selfKeyword Constant
highlight! link CocSem_semicolon Normal
highlight! link CocSem_string String
highlight! link CocSem_struct Structure
highlight! link CocSem_type Type
highlight! link CocSem_typeAlias Type
highlight! link CocSem_typeParameter Type

endif " if 0

" Modifications for highlight groups
hi! link EndOfBuffer Ignore
hi! link CocDiffAdd DiffAdded
hi! link CocDiffChange DiffLine
hi! link CocDiffDelete DiffRemoved
