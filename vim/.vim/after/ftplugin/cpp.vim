"==============================================================================
" General Settings
"------------------------------------------------------------------------------
setlocal foldmethod=syntax
setlocal foldlevel=10

"==============================================================================
" Commenting
"------------------------------------------------------------------------------
" Use // instead of /**/ for line comments (vim-commentary)
setlocal commentstring=//\ %s

" Use ys<textobj>/ to comment out text objects with /**/ (vim-surround)
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

" Customize highlight groups for current position and breakpoints
hi! link debugPC IncSearch
hi! link debugBreakpoint Error

let g:termdebug_config = {}
let g:termdebug_config['sign'] = ''                    " Customize the breakpoint sign
let g:termdebug_config['variables_window'] = 1          " Show the variables window by default
let g:termdebug_config['variables_window_height'] = 15  " Set the variables window height
let g:termdebug_config['wide'] = 1                      " Use a vertical split without changing 'columns'
