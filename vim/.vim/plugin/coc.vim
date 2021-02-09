"==============================================================================
" General settings
"------------------------------------------------------------------------------
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-json']

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" " Better display for messages
" set cmdheight=2

" You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

"==============================================================================
" Remaps
"------------------------------------------------------------------------------
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> <LocalLeader>gf <Plug>(coc-format)
nmap <silent> <LocalLeader>gd <Plug>(coc-definition)
nmap <silent> <LocalLeader>gy <Plug>(coc-type-definition)
nmap <silent> <LocalLeader>gi <Plug>(coc-implementation)
nmap <silent> <LocalLeader>gr <Plug>(coc-references)

" Try first quickfix action for diagnostics on the current line.
nmap <silent> <LocalLeader>gx <Plug>(coc-fix-current)

" Remap for rename current word
nmap <silent> <LocalLeader>rn <Plug>(coc-rename)

" Toggle coc-explorer
nmap <silent> <Leader>e :CocCommand explorer<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Toggle get gutter info
nmap <silent> <Leader>g :CocCommand git.toggleGutters<CR>

" Navigate hunks of current buffer
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)

"==============================================================================
" Custom highlights
"------------------------------------------------------------------------------
hi CocErrorSign guifg=LightRed
hi CocWarningSign guifg=Orange
