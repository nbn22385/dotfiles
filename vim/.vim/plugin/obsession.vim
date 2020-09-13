set sessionoptions-=options          " Do not store global and local values in a session
let s:obsession_autoload_session = 1 " Automatically use Session.vim if it exists

augroup AutoSourceSession
  autocmd!
  autocmd VimEnter * nested
        \ if get(s:, 'obsession_autoload_session', 0) && !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END
