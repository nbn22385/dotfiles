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
      \ 'coc-snippets',
      \ 'coc-yaml']

"==============================================================================
" Mappings
"------------------------------------------------------------------------------
" Toggle coc-explorer
nmap <Leader>e <Cmd>CocCommand explorer<CR>

" Navigate diagnostics
nmap [d <Plug>(coc-diagnostic-prev)
nmap ]d <Plug>(coc-diagnostic-next)

" Git
nmap [g <Plug>(coc-git-prevchunk)
nmap ]g <Plug>(coc-git-nextchunk)
nmap gcu <Cmd>CocCommand git.chunkUndo<CR>

" LSP
nmap <LocalLeader>ga <Plug>(coc-codeaction-line)
nmap <LocalLeader>gd <Plug>(coc-definition)
nmap <LocalLeader>gD <Plug>(coc-declaration)
nmap <LocalLeader>gi <Plug>(coc-implementation)
nmap <LocalLeader>gq <Plug>(coc-format)
nmap <LocalLeader>gr <Plug>(coc-references)
nmap <LocalLeader>gx <Plug>(coc-fix-current)
nmap <LocalLeader>rn <Plug>(coc-rename)

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <Tab>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use K to show documentation in preview window.
nnoremap K <Cmd>call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

endif
