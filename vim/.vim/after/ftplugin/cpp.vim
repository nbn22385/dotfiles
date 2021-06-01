packadd vim-lsp-cxx-highlight

"==============================================================================
" General Settings
"------------------------------------------------------------------------------
" Folds are syntax specific
setlocal foldmethod=syntax
setlocal foldlevel=10

" Disable auto-commenting
setlocal formatoptions-=c " when wrapping a comment line
setlocal formatoptions-=r " when pressing Enter
setlocal formatoptions-=o " when using o or O command
setlocal formatoptions-=j " when joining lines

"==============================================================================
" Commenting
"------------------------------------------------------------------------------
" Use // instead of /**/ for line comments (vim-commentary)
setlocal commentstring=//\ %s

" Use / to comment out text objects with /**/ (vim-surround)
" see h: surround-customizing
let g:surround_47 = "/* \r */"

" Comment out the current word under cursor
nnoremap <localleader>/ ciw/* <c-r>" */<esc>

" Comment out the current visual selection
xnoremap <localleader>/ c/* <c-r>" */<esc>

"==============================================================================
" Errorformat strings
"------------------------------------------------------------------------------
" CTest + googletest
setlocal errorformat^=%>%f:%l:%c:\ %m

" CTest + catch2
setlocal errorformat^=%.%#:\ %f:%l:\ %m

" CTest + gcc
setlocal errorformat^=%m\\,\ file\ %f\\,\ line\ %l%.

