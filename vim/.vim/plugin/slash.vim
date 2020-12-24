" Places the current match at the center of the window
noremap <plug>(slash-after) zz

" Blinking cursor after search using Vim 8 timer
if has('timers')
  " Blink 2 times with 50ms interval
  noremap <expr> <plug>(slash-after) 'zz'.slash#blink(1, 50)
endif
