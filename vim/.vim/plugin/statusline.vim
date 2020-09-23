" https://github.com/protesilaos/dotfiles/blob/master/vim/.vim/vimrc_modules/protline.vimrc
" https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" https://github.com/sunaku/vim-modusline/blob/master/plugin/modusline.vim

set statusline=%!ActiveStatus()

let g:modecolors = {
      \ 'n'      : '%#StatusLine#',
      \ 'no'     : '%#DiffChange#',
      \ 'v'      : '%#DiffAdd#',
      \ 'V'      : '%#DiffAdd#',
      \ "\<C-V>" : '%#DiffAdd#',
      \ 's'      : '%#WildMenu#',
      \ 'S'      : '%#WildMenu#',
      \ "\<C-S>" : '%#WildMenu#',
      \ 'i'      : '%#PmenuSel#',
      \ 'R'      : '%#Error#',
      \ 'Rv'     : '%#Error#',
      \ 'c'      : '%#Search#',
      \ 'cv'     : '%#MatchParen#',
      \ 'ce'     : '%#MatchParen#',
      \ 'r'      : '%#Todo#',
      \ 'rm'     : '%#Todo#',
      \ 'r?'     : '%#Todo#',
      \ '!'      : '%#IncSearch#',
      \ 't'      : '%#StatusLineTerm#',
      \ 'ic'     : '%#DiffChange#',
      \ 'Rc'     : '%#DiffChange#'}

let g:currentmode = {
      \ 'n'      : 'N',
      \ 'no'     : 'N·Operator Pending',
      \ 'v'      : 'V',
      \ 'V'      : 'V·Line',
      \ "\<C-V>" : 'V·Block',
      \ 's'      : 'Select',
      \ 'S'      : 'S·Line',
      \ "\<C-S>" : 'S·Block',
      \ 'i'      : 'I',
      \ 'R'      : 'Replace',
      \ 'Rv'     : 'V·Replace',
      \ 'c'      : 'CMD',
      \ 'cv'     : 'Vim Ex',
      \ 'ce'     : 'Ex',
      \ 'r'      : 'Prompt',
      \ 'rm'     : 'more',
      \ 'r?'     : 'Confirm',
      \ '!'      : 'Shell',
      \ 't'      : 'Terminal'}

function! CurrentMode() abort
  return toupper(get(g:currentmode, mode(), '???')) . (&paste == 1 ? "-PASTE" : "")
endfunction

function! GetCurrentBranch()
  " if winwidth < 100, truncate to 15 characters, else show full branch name
  return fugitive#head() != '' ? (winwidth(0) < 100 ? '  '.fugitive#head()[0:15] : '  '.fugitive#head()) : ''
endfunction

function! LinterStatus() abort
  if exists("g:ale_enabled")
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf(' ✗%d ', all_errors)
  else
    return ""
  endif
endfunction

function! ActiveStatus() abort
  let statusline=""
  let statusline.=get(g:modecolors, mode(), '%#ErrorMsg#')
  let statusline.=" %{CurrentMode()} %<"
  let statusline.="%#StatusLine#"           " filename color
  let statusline.="\ %f\ "
  let statusline.="%#TabLineSel#"           " modified flag color
  let statusline.="%{&modified=='nomodified' ? '' : '●'}"
  let statusline.="%#StatusLine#"           " line info color
  let statusline.="%="                      " spacer
  let statusline.="\ %3l:%c\ %-p%%\ "
  let statusline.="%#StatusLine#"           " branch/flags color
  let statusline.="%r%h"
  let statusline.="%{ObsessionStatus()} "
  let statusline.="%{GetCurrentBranch()} "
  let statusline.="%#Error#"                " linter error color
  let statusline.="%{LinterStatus()}"
  return statusline
endfunction

function! InactiveStatus()
  let statusline="    "
  let statusline.="%#StatusLineNC#"         " filename color
  let statusline.="%f "
  let statusline.="%#TabLineSel#"           " modified flag color
  let statusline.="%{&modified=='nomodified' ? '' : '●'}"
  let statusline.="%#StatusLineNC#"         " branch/flags color
  let statusline.="%="                      " spacer
  let statusline.="%r%h"
  let statusline.="%{ObsessionStatus()} "
  let statusline.="%{GetCurrentBranch()} "
  return statusline
endfunction

augroup status
  autocmd!
  autocmd BufEnter,WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd BufLeave,WinLeave * setlocal statusline=%!InactiveStatus()
augroup END
