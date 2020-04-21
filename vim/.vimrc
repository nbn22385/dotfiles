set nocompatible           " be iMproved, required
filetype plugin indent on  " Filetype detection

set number	         " Show line numbers
set showmatch	       " Highlight matching brace
syntax enable        " Use syntax highlighting
set background=dark  " Optimize for dark background

set hlsearch	  " Highlight all search results
set smartcase	  " Enable smart-case search
set ignorecase	" Always case-insensitive
set incsearch	  " Searches for strings incrementally

set autoindent	   " Auto-indent new lines
set expandtab	     " Use spaces instead of tabs
set tabstop=2	     " Number of spaces a tab counts for
set shiftwidth=2	 " Number of auto-indent spaces
set smartindent	   " Enable smart-indent
set smarttab	     " Enable smart-tabs
set softtabstop=2	 " Number of spaces per Tab

set ruler	      " Show row and column ruler information
set cursorline  " Highlight selected row

set undolevels=1000	            " Number of undo levels
set backspace=indent,eol,start	" Backspace behaviour

colorscheme nord

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 0
let g:netrw_altv = 1
let g:netrw_winsize = 25
