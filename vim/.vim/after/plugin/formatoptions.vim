" Disable auto-commenting on new lines
augroup DisableAutoCommenting
  autocmd!
  autocmd FileType * set fo-=c fo-=r fo-=o fo-=j
augroup END
