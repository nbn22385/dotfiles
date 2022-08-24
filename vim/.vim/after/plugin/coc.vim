if &runtimepath=~'coc.nvim'
"==============================================================================
" General settings
"------------------------------------------------------------------------------
" List of extensions to install by default
let g:coc_global_extensions = [
      \ 'coc-clangd',
      \ 'coc-explorer',
      \ 'coc-git',
      \ 'coc-json',
      \ 'coc-yaml']

"==============================================================================
" Mappings
"------------------------------------------------------------------------------
" Navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Navigate hunks of current buffer
nmap <silent> [g <Plug>(coc-git-prevchunk)
nmap <silent> ]g <Plug>(coc-git-nextchunk)

" LSP-related remaps
nmap <silent> <LocalLeader>gd <Plug>(coc-definition)
nmap <silent> <LocalLeader>gi <Plug>(coc-implementation)
nmap <silent> <LocalLeader>gq <Plug>(coc-format)
nmap <silent> <LocalLeader>gr <Plug>(coc-references)
nmap <silent> <LocalLeader>gx <Plug>(coc-fix-current)
nmap <silent> <LocalLeader>rn <Plug>(coc-rename)

" Toggle coc-explorer
nmap <silent> <Leader>e :CocCommand explorer<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation() abort
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <Tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-Tab> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <CR> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif
