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

" CTest + gcc
setlocal errorformat+=%m\\,\ file\ %f\\,\ line\ %l%.

"==============================================================================
" ALE Mappings
"------------------------------------------------------------------------------
" if exists('g:loaded_ale')
"   imap <buffer> <LocalLeader><Space> <Plug>(ale_complete)
"   nmap <buffer> <LocalLeader>gd <Plug>(ale_go_to_definition)
"   nmap <buffer> <LocalLeader>fr <Plug>(ale_find_references)
"   nmap <buffer> <LocalLeader>re <Plug>(ale_rename)
" endif
