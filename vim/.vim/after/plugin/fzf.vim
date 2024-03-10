if &runtimepath=~'fzf.vim'
  "==============================================================================
  " General config
  "------------------------------------------------------------------------------
  " Preview window on the right side, hidden by default, ctrl-p to toggle
  let g:fzf_preview_window = ['right:50%:hidden', 'ctrl-d']

  " Enable per-command history
  " - History files will be stored in the specified directory
  " - When set, CTRL-N and CTRL-P will be bound to 'next-history' and
  "   'previous-history' instead of 'down' and 'up'.
  let g:fzf_history_dir = '~/.local/share/fzf-history'

  " Use floating window if supported
  if v:version >= 802
    let g:fzf_layout = { 'window': { 'width': 1.0, 'height': 0.4, 'border': 'sharp', 'yoffset': 1, 'relative': v:true} }
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
        \   'rg --hidden --line-number --color=always --smart-case --glob "!{.git,node_modules}" -- '
        \   .shellescape(<q-args>), 1, fzf#vim#with_preview(), <bang>0)

  " [Helptags] add a prompt
  command! -bar -bang Helptags
        \ call fzf#vim#helptags(
        \   fzf#vim#with_preview({ 'options': ["--prompt=Help> "], 'placeholder': "--tag {2}:{3}:{4}" }), <bang>0)

  "==============================================================================
  " Mappings
  "------------------------------------------------------------------------------
  nnoremap <silent> <expr> <leader>f 
        \ (len(system('git rev-parse')) ? '<Cmd>Files' : '<Cmd>GFiles')."\<CR>"
  nnoremap <silent> <leader>B <Cmd>Buffers<CR>
  nnoremap <silent> <leader>C <Cmd>Colors<CR>
  nnoremap <silent> <leader>F <Cmd>Files<CR>
  nnoremap <silent> <leader>H <Cmd>Helptags<CR>
  nnoremap <silent> <leader>R <Cmd>Rg<CR>
  nnoremap <silent> <leader>T <Cmd>Tags<CR>
  nnoremap <silent> <leader>Y <Cmd>History<CR>

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

endif
