function! EnableOverlength(...) abort
  let col = get(a:,1,80)
  if type(col) == type(0)
    highlight link OverLength WarningMsg 
    execute 'match OverLength /\%>' . col . 'v.\+/'
    echom 'Enabled highlighting long lines (after column ' . col . ')'
  else
    echoe 'Invalid column number provided: ' . col
  endif
endfunction

function! DisableOverlength() abort
  match none
  echom 'Disabled highlighting long lines'
endfunction

command! -nargs=? EnableOverlength call EnableOverlength(<args>)
command! DisableOverlength call DisableOverlength()
