" fzf settings
if executable('fzf')
  " Empty value to disable preview window altogether
  " let g:fzf_preview_window = ''

  " Command to generate tags file
  let g:fzf_tags_command = 'ctags -R --languages=C++ --exclude="build" --exclude=".git"'

  " Use floating window if supported
  if v:version >= 802
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7, 'border': 'sharp'} }
  else
    let g:fzf_layout = { 'window': '10new' }
  endif

  " custom Files command with bat preview (taken from :h fzf-vim-example-customizing-files-command)
  command! -bang -nargs=? -complete=dir Files
        \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)

  " <leader>f -> open file list
  nnoremap <expr> <leader>f (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"

  nnoremap <leader>b :Buffers<CR>
  nnoremap <leader>t :Tags<CR>
endif
