function! Try_edit(the_file) abort
  if filereadable(a:the_file)
    execute 'edit ' . a:the_file
  else
    echom 'file wasn''t readable'
  endif
endfunction

function! Cool_gf() abort
  let regex = '[/.]'

  if search(regex,'z',line('.'))
    " search forwards
    let the_file = expand('<cWORD>')
    call Try_edit(the_file)
  elseif search(regex,'b',line('.'))
    " search backwards
    let the_file = expand('<cWORD>')
    call Try_edit(the_file)
  else
    echom 'didn''t find a file'
  endif
endfunction

nnoremap <leader>gf :call Cool_gf()<cr>
