" startify
let g:startify_session_autoload = 0
let g:startify_session_persistence = 1
let g:startify_session_sort = 1 " Sort sessions by modification time
let g:header_ascii = [
      \' ██╗   ██╗██╗███╗   ███╗',
      \' ██║   ██║██║████╗ ████║',
      \' ██║   ██║██║██╔████╔██║',
      \' ╚██╗ ██╔╝██║██║╚██╔╝██║',
      \'  ╚████╔╝ ██║██║ ╚═╝ ██║',
      \'   ╚═══╝  ╚═╝╚═╝     ╚═╝',
      \]
let g:startify_custom_header = 'startify#pad(g:header_ascii)'
let g:startify_enable_special = 0
let g:startify_lists = [
      \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
      \ { 'type': 'sessions',  'header': ['   Sessions']       },
      \ { 'type': 'files',     'header': ['   Recent Files']            },
      \ { 'type': 'dir',       'header': ['   Recent Files in '. getcwd()] },
      \ { 'type': 'commands',  'header': ['   Commands']       },
      \ ]
autocmd user startifyallbuffersopened let &path = getcwd() . '/**'
let g:startify_bookmarks = [ {'c': '~/.vim/vimrc'}, {'d': '~/dotfiles'} ]
