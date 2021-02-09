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

" Prefer // instead of /**/ comments (vim-commentary)
setlocal commentstring=//\ %s

"==============================================================================
" Errorformat strings
"------------------------------------------------------------------------------
" CTest + googletest
setlocal errorformat^=%>%f:%l:%c:\ %m

" CTest + catch2
setlocal errorformat^=%.%#:\ %f:%l:\ %m

" CTest + gcc
setlocal errorformat^=%m\\,\ file\ %f\\,\ line\ %l%.

