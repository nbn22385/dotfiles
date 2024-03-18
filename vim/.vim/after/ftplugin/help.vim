" close help window
nnoremap q <Cmd>helpclose<CR>

" navigate help tags with up/down/enter
nnoremap <buffer> <down> <Cmd>call search('\|\S\{-}\|')<cr>
nnoremap <buffer> <up> <Cmd>call search('\|\S\{-}\|','b')<cr>
nnoremap <buffer> <cr> <c-]>
