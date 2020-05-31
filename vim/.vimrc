colorscheme nord

set nocompatible                " be iMproved, required
filetype plugin indent on       " Filetype detection

set number	                    " Show line numbers
set showmatch                   " Highlight matching brace
syntax enable                   " Use syntax highlighting
set background=dark             " Optimize for dark background

set hlsearch                    " Highlight all search results
set smartcase	                  " Enable smart-case search
set ignorecase	                " Always case-insensitive
set incsearch	                  " Searches for strings incrementally

set autoindent	                " Auto-indent new lines
set expandtab	                  " Use spaces instead of tabs
set tabstop=2                   " Number of spaces a tab counts for
set shiftwidth=2                " Number of auto-indent spaces
set smartindent	                " Enable smart-indent
set smarttab	                  " Enable smart-tabs
set softtabstop=2	              " Number of spaces per Tab

set ruler	                      " Show row and column ruler information
set cursorline                  " Highlight selected row
highlight clear CursorLine      " Only highlight selected row's line number
set laststatus=2                " Always show status bar 
set noshowmode                  " Hide mode from last line

set undolevels=1000	            " Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

set path=$PWD/**                " enable fuzzy finding in the vim command line
set wildmenu                    " enable fuzzy menu
set wildignore+=**/.git/**      " Use the wildmenu for tab completion
set wildmode=longest:full,full  " Wildmenu complete longest common string

" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>

set splitbelow splitright
nnoremap <C-j> <C-W><C-J>
nnoremap <C-k> <C-W><C-K>
nnoremap <C-l> <C-W><C-L>
nnoremap <C-h> <C-W><C-H>

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1

" Lightline config 
let g:lightline = {} 
let g:lightline.colorscheme = 'nord' 
let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'gitbranch', 'readonly', 'filename', 'modified' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ],
      \            [ 'filetype' ] ] }
let g:lightline.inactive = {
      \ 'left': [ [ 'filename' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ] ] }
let g:lightline.component_function = {
      \ 'gitbranch': 'MyFugitive' }

function! MyFugitive()
  if exists("*FugitiveHead")
    let _ = FugitiveHead()
    return strlen(_) ? ' '._ : ''
  endif
endfunction
