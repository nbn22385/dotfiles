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
" Toggle coc-explorer
nmap <silent> <Leader>e :CocCommand explorer<CR>

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

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

endif
