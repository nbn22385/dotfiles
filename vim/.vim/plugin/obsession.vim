" automatically use Session.vim if it exists
let s:obsession_autoload_session = 1

augroup sourcesession
  autocmd!
  autocmd VimEnter * nested
        \ if get(s:, 'obsession_autoload_session', 0) && !argc() && empty(v:this_session) && filereadable('Session.vim') |
        \   source Session.vim |
        \ endif
augroup END
