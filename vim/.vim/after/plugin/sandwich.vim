" Use vim-surround mappings
runtime macros/sandwich/keymap/surround.vim

" Text objects to select a text surrounded by brackets or user-specified characters
xmap is <Plug>(textobj-sandwich-query-i)
xmap as <Plug>(textobj-sandwich-query-a)
omap is <Plug>(textobj-sandwich-query-i)
omap as <Plug>(textobj-sandwich-query-a)

" Text objects to select the nearest surrounded text automatically
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

let g:sandwich#recipes += [
      \ {'buns': ['<', '>']},
      \ {'buns': ['/* ', ' */']}
      \ ]