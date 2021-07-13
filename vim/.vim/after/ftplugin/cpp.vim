"==============================================================================
" General Settings
"------------------------------------------------------------------------------
" Semantic highlighting via clangd lsp
packadd vim-lsp-cxx-highlight

" Folds are syntax specific
setlocal foldmethod=syntax
setlocal foldlevel=10

"==============================================================================
" Commenting
"------------------------------------------------------------------------------
" Use // instead of /**/ for line comments (vim-commentary)
setlocal commentstring=//\ %s

" Use / to comment out text objects with /**/ (vim-surround)
" see h: surround-customizing
let g:surround_47 = "/* \r */"

" Comment out the current word under cursor
nnoremap <buffer> <localleader>/ ciw/* <c-r>" */<esc>

" Comment out the current visual selection
xnoremap <buffer> <localleader>/ c/* <c-r>" */<esc>

"==============================================================================
" Errorformat strings
"------------------------------------------------------------------------------
" CTest + googletest
setlocal errorformat^=%>%f:%l:%c:\ %m

" CTest + catch2
setlocal errorformat^=%.%#:\ %f:%l:\ %m

" CTest + gcc
setlocal errorformat^=%m\\,\ file\ %f\\,\ line\ %l%.

"==============================================================================
" Termdebug
"------------------------------------------------------------------------------
packadd termdebug
let g:termdebug_wide=1
hi! link debugPC IncSearch
hi! link debugBreakpoint Error
