if &runtimepath=~'vim-sandwich'

" Disable default mappings to remove delay for 's' key
let g:sandwich_no_default_key_mappings = 1

" Use vim-surround mappings
runtime macros/sandwich/keymap/surround.vim

" Text objects to select the nearest surrounded text automatically
xmap iss <Plug>(textobj-sandwich-auto-i)
xmap ass <Plug>(textobj-sandwich-auto-a)
omap iss <Plug>(textobj-sandwich-auto-i)
omap ass <Plug>(textobj-sandwich-auto-a)

" Recipes for C++
let g:sandwich#recipes += [
      \ {'buns': ['<', '>']},
      \ {'buns': ['/* ', ' */']}
      \ ]

endif
