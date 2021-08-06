" Disable auto-commenting using the following flags:
" c : when wrapping a comment line
" r : when pressing Enter
" o : when using o or O command
" j : when joining lines
augroup DisableAutoCommenting
  autocmd!
  autocmd FileType * set fo-=c fo-=r fo-=o fo-=j
augroup END
