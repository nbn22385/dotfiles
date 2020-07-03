" based off of sources:
" https://github.com/protesilaos/dotfiles/blob/master/vim/.vim/vimrc_modules/protline.vimrc
" https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
"
" date function source:
" https://cromwell-intl.com/open-source/vim-word-count.html

" Dictionary: take mode() input -> longer notation of current mode
" mode() is defined by Vim
let g:currentmode={
      \ 'n'  : 'N',
      \ 'no' : 'N·Operator Pending ',
      \ 'v'  : 'V',
      \ 'V'  : 'V·Line',
      \ '^V' : 'V·Block',
      \ 's'  : 'Select ',
      \ 'S'  : 'S·Line ',
      \ '^S' : 'S·Block ',
      \ 'i'  : 'I',
      \ 'R'  : 'Replace ',
      \ 'Rv' : 'V·Replace ',
      \ 'c'  : 'CMD',
      \ 'cv' : 'Vim Ex ',
      \ 'ce' : 'Ex ',
      \ 'r'  : 'Prompt ',
      \ 'rm' : 'More ',
      \ 'r?' : 'Confirm ',
      \ '!'  : 'Shell ',
      \ 't'  : 'Terminal '}

function! ProtLineCurrentMode() abort
  let l:modecurrent = mode()
  " use get() -> fails safely, since ^V doesn't seem to register
  " 3rd arg is used when return of mode() == 0, which is case with ^V
  " thus, ^V fails -> returns 0 -> replaced with 'V Block'
  let l:modestr = toupper(get(g:currentmode, l:modecurrent, 'V·Block'))
  return l:modestr
endfunction

function! ProtLinePasteMode()
  let paste_status = &paste
  if paste_status == 1
    return "paste"
  else
    return ""
  endif
endfunction

function! GetCurrentBranch()
  return fugitive#head() != '' ? '  '.fugitive#head()[0:15].' ' : ''
endfunction

" function! LinterStatus() abort
"     let l:counts = ale#statusline#Count(bufnr(''))
"     let l:all_errors = l:counts.error + l:counts.style_error
"     let l:all_non_errors = l:counts.total - l:all_errors
"     return l:counts.total == 0 ? '' : printf('  ✗%d ', all_errors)
" endfunction

function! ProtLineActiveStatus()
  let statusline=""
  let statusline.="%#DiffChange#"         " NORMAL mode color
  let statusline.="\ %{ProtLineCurrentMode()}\%-6{ProtLinePasteMode()}"
  let statusline.="\ %<"
  let statusline.="%#StatusLineNC#"       " filename color
  let statusline.="\ %f\ "
  let statusline.="%#StatusLineNC#"       " line number color
  let statusline.="%=" 
  let statusline.="\ %3l:%c\ %3p%%\ "
  let statusline.="%#StatusLine#"         " branch color
  let statusline.="%{GetCurrentBranch()}"
  let statusline.="%r%h"
  let statusline.="%#DiffDelete#"           " linter error color
  " let statusline.="%{LinterStatus()}"
  let statusline.="%#DiffChange#"         " buffer number color
  let statusline.=" ".bufnr('%')." "
  let statusline.="%#DiffText#"           " flags color
  let statusline.="%{&modified=='nomodified' ? '' : ' ⚡'}"
  return statusline
endfunction

function! ProtLineActiveStatusInsertMode()
  let statusline=""
  let statusline.="%#DiffAdd#"            " INSERT mode color
  let statusline.="\ %{ProtLineCurrentMode()}\%-6{ProtLinePasteMode()}"
  let statusline.="\ %<"
  let statusline.="%#StatusLine#"         " filename color
  let statusline.="\ %f\ "
  let statusline.="%#StatusLine#"         " line number color
  let statusline.="%=" 
  let statusline.="\ %3l:%c\ %3p%%\ "
  let statusline.="%#StatusLine#"         " branch color
  let statusline.="%{GetCurrentBranch()}"
  let statusline.="%r%h"
  let statusline.="%#DiffAdd#"            " buffer number color
  let statusline.=" ".bufnr('%')." "
  let statusline.="%#DiffText#"           " flags color
  let statusline.="%{&modified=='nomodified' ? '' : ' ⚡'}"
  return statusline
endfunction

function! ProtLineInactiveStatus()
  let statusline=""
  let statusline.="\ %<"
  let statusline.="%#StatusLineNC#"       " inactive filename color
  let statusline.="%f"
  let statusline.="%="
  let statusline.="%#StatusLineNC#"       " branch color
  let statusline.="%{GetCurrentBranch()}"
  let statusline.="%r%h"
  let statusline.="%#StatusLine#"         " buffer number color
  let statusline.=" "
  let statusline.="%(%{bufnr('%')}%)"
  let statusline.=" "
  let statusline.="%#CursorLineNr#"       " flags color
  let statusline.="%{&modified=='nomodified' ? '' : ' ⚡'}"
  return statusline
endfunction

set laststatus=2
set noshowmode
set statusline=%!ProtLineActiveStatus()

augroup status
  autocmd!
  autocmd BufEnter,WinEnter * setlocal statusline=%!ProtLineActiveStatus()
  autocmd BufLeave,WinLeave * setlocal statusline=%!ProtLineInactiveStatus()
  autocmd InsertEnter * setlocal statusline=%!ProtLineActiveStatusInsertMode()
  autocmd InsertLeave * setlocal statusline=%!ProtLineActiveStatus()
augroup END

