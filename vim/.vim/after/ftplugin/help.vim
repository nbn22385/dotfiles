" close help window
nnoremap <buffer> <silent> q <Cmd>helpclose<CR>

" navigate help tags with up/down/enter
nnoremap <buffer> <silent> <down> :call search('\|\S\{-}\|')<cr>
nnoremap <buffer> <silent> <up> :call search('\|\S\{-}\|','b')<cr>
nnoremap <buffer> <cr> <c-]>
