if g:loaded_fzf
  "==============================================================================
  " General config
  "------------------------------------------------------------------------------
  " Empty value to disable preview window altogether
  " let g:fzf_preview_window = ''
  " Preview window on the right side, hidden by default, ctrl-p to toggle
  let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-p']

  " Use floating window if supported
  if v:version >= 802
    let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.7, 'border': 'sharp'} }
  else
    let g:fzf_layout = { 'window': '10new' }
  endif

  " [Buffers] Jump to the existing window if possible
  let g:fzf_buffers_jump = 1

  " [Tags] Command to generate tags file
  let g:fzf_tags_command = 'ctags -R --languages=C++ --exclude="build" --exclude=".git"'

  "==============================================================================
  " Command overrides
  "------------------------------------------------------------------------------
  " [Rg] search hidden files
  command! -bang -nargs=* Rg
        \ call fzf#vim#grep(
        \   'rg --hidden --column --line-number --no-heading --color=always --smart-case -- '.shellescape(<q-args>), 1,
        \   fzf#vim#with_preview(), <bang>0)

  "==============================================================================
  " Mappings
  "------------------------------------------------------------------------------
  nnoremap <silent> <expr> <leader>f 
        \ (len(system('git rev-parse')) ? ':Files' : ':GFiles')."\<cr>"
  nnoremap <silent> <leader>B :Buffers<cr>
  nnoremap <silent> <leader>C :Colors<cr>
  nnoremap <silent> <leader>F :Files<cr>
  nnoremap <silent> <leader>H :History<cr>
  nnoremap <silent> <leader>R :Rg<cr>
  nnoremap <silent> <leader>T :Tags<cr>

  " CTRL-A CTRL-Q to select all and build quickfix list
  function! s:build_quickfix_list(lines)
    call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
    copen
    cc
  endfunction

  let g:fzf_action = {
        \ 'ctrl-q': function('s:build_quickfix_list'),
        \ 'ctrl-t': 'tab split',
        \ 'ctrl-x': 'split',
        \ 'ctrl-v': 'vsplit' }

  let $FZF_DEFAULT_OPTS .= ' --bind ctrl-a:select-all'

  "==============================================================================
  " Custom colors
  "------------------------------------------------------------------------------
  let g:fzf_colors = {
        \ 'fg':      ['fg', 'Normal'],
        \ 'bg':      ['bg', 'Normal'],
        \ 'hl':      ['fg', 'Comment'],
        \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
        \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
        \ 'hl+':     ['fg', 'Statement'],
        \ 'info':    ['fg', 'PreProc'],
        \ 'border':  ['fg', 'StatusLine'],
        \ 'prompt':  ['fg', 'Conditional'],
        \ 'pointer': ['fg', 'Exception'],
        \ 'marker':  ['fg', 'Keyword'],
        \ 'spinner': ['fg', 'Label'],
        \ 'header':  ['fg', 'Comment'] }

endif
