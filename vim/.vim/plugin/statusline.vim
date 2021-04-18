if 1
" https://github.com/protesilaos/dotfiles/blob/master/vim/.vim/vimrc_modules/protline.vimrc
" https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" https://github.com/sunaku/vim-modusline/blob/master/plugin/modusline.vim

set statusline=%!ActiveStatus()

let g:modecolors = {
      \ 'n'      : '%#StatusLineNC#',
      \ 'i'      : '%#DiffAdd#',
      \ 'v'      : '%#DiffChange#',
      \ 'V'      : '%#DiffChange#',
      \ "\<C-V>" : '%#DiffChange#',
      \ 't'      : '%#StatusLineTerm#',
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

function! CurrentBranch()
  if winwidth(0) <= 50
    return ''
  endif
  if exists('g:loaded_fugitive')
    let l:branch = fugitive#head() . ' '
    return fugitive#head() !=? '' ? (winwidth(0) < 100 ? '  ' . l:branch[0:15] : '  ' . l:branch) : ''
  else
    return ''
  endif
endfunction

function! CocStatus() abort
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
    let l:status = ObsessionStatus('   ', ' ﭸ  ')
    return l:status != '' ? l:status : ''
  else
    return ''
  endif
endfunction

function! ActiveStatus() abort
  let s=''                         " - section 0
  let s.=get(g:modecolors, mode(), '')
  let s.=' %{CurrentMode()} %<'    "   mode
  let s.='%#StatusLineNC#'         " - section 1
  let s.=' %f'                     "   filename
  let s.='%{ReadOnlyStatus()}'     "   readonly flag
  let s.='%#TabLineSel#'           " - section 2
  let s.='%{ModifiedStatus()}'     "   modified flag
  let s.='%#StatusLineNC#'         " - section 3 
  let s.='%='                      "   blank space
  let s.=' %3l:%c  %-p%% '         "   lineinfo, percent
  let s.='%{SessionStatus()}'      "   session status
  let s.='%#StatusLineNC#'         " - section 4
  let s.='%{CurrentBranch()}'      "   git branch
  let l:coc_result = CocStatus()   "   coc status
  let s.= 
        \ (l:coc_result['total'] > 0 ? '%#Error#' : '%#StatusLineNC#') 
        \ . l:coc_result['str']
  return s
endfunction

function! InactiveStatus()
  let s='%#VertSplit#    '         " - section 0
  let s.='%f'                      "   filename
  let s.='%{ReadOnlyStatus()}'     "   readonly flag
  let s.='%{ModifiedStatus()}'     "   modified flag
  let s.='%='                      " - section 1
  let s.='%{SessionStatus()}'      "   session status
  let s.='%{CurrentBranch()}'      "   git branch
  let l:coc_result = CocStatus()   "   coc status
  let s.= 
        \ (l:coc_result['total'] > 0 ? '%#ErrorMsg#' : '%#VertSplit#') 
        \ . l:coc_result['str']
  return s
endfunction

augroup status
  autocmd!
  autocmd BufEnter,WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd BufLeave,WinLeave * setlocal statusline=%!InactiveStatus()
augroup END
endif

scriptencoding utf-8
