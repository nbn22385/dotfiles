if 1

set statusline=%!ActiveStatus()

" colors with bg of statusline but color text
" FoldColumn (blue)
" TablineSel (green)
" Todo (orange)
" GitGutterAdd (green)
" GitGutterChange (blue)
" GitGutterDelete (red)
" GitGutterChangeDelete (purple)

let g:modecolors = {
      \ 'n'      : '%#GitGutterChange#',
      \ 'i'      : '%#GitGutterChangeDelete#',
      \ 'v'      : '%#Todo#',
      \ 'V'      : '%#Todo#',
      \ "\<C-V>" : '%#Todo#',
      \ 't'      : '%#GitGutterAdd#',
      \ 'no'     : '%#DiffChange#',
      \ 's'      : '%#WildMenu#',
      \ 'S'      : '%#WildMenu#',
      \ "\<C-S>" : '%#WildMenu#',
      \ 'R'      : '%#Error#',
      \ 'Rv'     : '%#Error#',
      \ 'c'      : '%#Search#',
      \ 'cv'     : '%#MatchParen#',
      \ 'ce'     : '%#MatchParen#',
      \ 'r'      : '%#Todo#',
      \ 'rm'     : '%#Todo#',
      \ 'r?'     : '%#Todo#',
      \ '!'      : '%#IncSearch#',
      \ 'ic'     : '%#DiffChange#',
      \ 'Rc'     : '%#DiffChange#'}

let g:currentmode = {
      \ 'n'      : 'N',
      \ 'i'      : 'I',
      \ 'v'      : 'V',
      \ 'V'      : 'VL',
      \ "\<C-V>" : 'VB',
      \ 't'      : 'T',
      \ 'no'     : 'N·Operator Pending',
      \ 's'      : 'Select',
      \ 'S'      : 'S·Line',
      \ "\<C-S>" : 'S·Block',
      \ 'R'      : 'R',
      \ 'Rv'     : 'V·Replace',
      \ 'c'      : 'CMD',
      \ 'cv'     : 'Vim Ex',
      \ 'ce'     : 'Ex',
      \ 'r'      : 'Prompt',
      \ 'rm'     : 'more',
      \ 'r?'     : 'Confirm',
      \ '!'      : 'Shell'}

function! CurrentMode() abort
  return toupper(get(g:currentmode, mode(), '???')) . (&paste == 1 ? '-PASTE' : '')
endfunction

function! CurrentBranch() abort
  if winwidth(0) <= 50
    return ''
  endif
  if exists('g:loaded_fugitive')
    let l:branch = fugitive#head()
    return fugitive#head() !=? '' ? (winwidth(0) < 80 ? '  ' . l:branch[0:15] . ' ' : '  ' . l:branch . ' ') : ''
  else
    return ''
  endif
endfunction

function! CocGitStatus() abort
  let l:dict = {'added':'','changed':'','deleted':'',}
  if winwidth(0) <= 50
    return l:dict
  endif
  if exists('b:coc_git_status')
    let l:status = b:coc_git_status
    let l:dict.added = substitute(matchstr(l:status, '\v\+\d+\s'), '+', ' ', '')
    let l:dict.changed = substitute(matchstr(l:status, '\v\~\d+\s'), '\~', ' ', '')
    let l:dict.deleted = substitute(matchstr(l:status, '\v\-\d+\s'), '-', ' ', '')
    return l:dict
  else
    return l:dict
  endif
endfunction

function! CocErrors() abort
  if exists('b:coc_diagnostic_info')
    let l:errors = get(b:coc_diagnostic_info, 'error', 0)
    let l:warnings = get(b:coc_diagnostic_info, 'warning', 0)
    let l:total = l:errors + l:warnings
    if l:total > 0
      return {'total' : l:total,
            \ 'str': ' ' . (l:errors != 0 ? '×' . string(l:errors) . ' ' : '') 
            \        . (l:warnings != 0 ? '•' . string(l:warnings) . ' ' : '')
            \ }
    else
      return {'total': l:total, 'str': '  '}
    endif
  else
    return {'total': -1, 'str': ''}
  endif
endfunction

function! ModifiedStatus() abort
  return &modified == 'nmodified' ? '' : '  '
endfunction

function! ReadOnlyStatus() abort
  return &modifiable ? '' : '  '
endfunction

function! SessionStatus() abort
  if winwidth(0) <= 50
    return ''
  endif
  if exists('g:loaded_obsession')
    let l:status = ObsessionStatus('   ')
    return l:status != '' ? l:status : ''
  else
    return ''
  endif
endfunction

function! ActiveStatus() abort
  let s=''                             " - section 0
  let s.=get(g:modecolors, mode(), '') "   mode color
  let s.=' %{CurrentMode()} %<'        "   mode
  let s.='%#StatusLine#'               " - section 1
  let s.=' %f'                         "   filename
  let s.='%{ReadOnlyStatus()}'         "   readonly flag
  let s.='%#TabLineSel#'               " - section 2
  let s.='%{ModifiedStatus()}'         "   modified flag
  let s.='%#StatusLine#'               " - section 3 
  let s.='%='                          "   blank space
  let s.=' %3l:%c  %-p%% '             "   lineinfo, percent
  let s.='%#Todo#%{SessionStatus()}'   "   session status
  let s.='%#StatusLine#'               " - section 4
  let s.='%#GitGutterChangeDelete#%{CurrentBranch()}'  " git branch
  " let s.='%#GitGutterAdd#%{CocGitStatus().added}'      " git status (added)
  " let s.='%#GitGutterChange#%{CocGitStatus().changed}' " git status (changed)
  " let s.='%#GitGutterDelete#%{CocGitStatus().deleted}' " git status (deleted)
  let s.='%#StatusLine#'               " - section 4
  let l:coc_result = CocErrors()       "   coc diagnostic info
  let s.= 
        \ (l:coc_result['total'] > 0 ? '%#GitGutterDelete#' : '%#TabLineSel#') 
        \ . l:coc_result['str']
  return s
endfunction

function! InactiveStatus() abort
  let s='%#StatusLineNC#    '          " - section 0
  let s.='%f'                          "   filename
  let s.='%{ReadOnlyStatus()}'         "   readonly flag
  let s.='%{ModifiedStatus()}'         "   modified flag
  let s.='%='                          " - section 1
  let s.='%{CurrentBranch()}'          "   git branch
  " let s.='%{CocGitStatus().added}'     "   git status (added)
  " let s.='%{CocGitStatus().changed}'   "   git status (changed)
  " let s.='%{CocGitStatus().deleted}'   "   git status (deleted)
  return s
endfunction

augroup status
  autocmd!
  autocmd BufEnter,WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd BufLeave,WinLeave * setlocal statusline=%!InactiveStatus()
augroup END

endif

scriptencoding utf-8

" resources
" https://github.com/protesilaos/dotfiles/blob/master/vim/.vim/vimrc_modules/protline.vimrc
" https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" https://github.com/sunaku/vim-modusline/blob/master/plugin/modusline.vim
