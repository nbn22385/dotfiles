if 1
" https://github.com/protesilaos/dotfiles/blob/master/vim/.vim/vimrc_modules/protline.vimrc
" https://www.reddit.com/r/vim/comments/6b7b08/my_custom_statusline/
" https://hackernoon.com/the-last-statusline-for-vim-a613048959b2
" https://github.com/sunaku/vim-modusline/blob/master/plugin/modusline.vim

scriptencoding utf-8            " Specify character encoding used in this file
set statusline=%!ActiveStatus()

let g:modecolors = {
      \ 'n'      : '%#MatchParen#',
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
      \ 'V'      : 'L',
      \ "\<C-V>" : 'B',
      \ 's'      : 'Select',
      \ 'S'      : 'S·Line',
      \ "\<C-S>" : 'S·Block',
      \ 'i'      : 'I',
      \ 'R'      : 'R',
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
  return toupper(get(g:currentmode, mode(), '???')) . (&paste == 1 ? '-PASTE' : '')
endfunction

function! CurrentBranch()
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
  return &modified == 'nmodified' ? '' : ' ● '
endfunction

function! ReadOnlyStatus() abort
  return &modifiable ? '' : '  '
endfunction

function! SessionStatus() abort
  if exists('g:loaded_obsession')
    let l:status = ObsessionStatus('   ', ' ﭸ  ')
    return l:status != '' ? l:status : ''
  else
    return ''
  endif
endfunction

function! ActiveStatus() abort
  let statusline=''                         " - section 0
  let statusline.=get(g:modecolors, mode(), '')
  let statusline.=' %{CurrentMode()} %<'    "   mode
  let statusline.='%#StatusLineNC#'         " - section 1
  let statusline.=' %f '                    "   filename
  let statusline.='%{ReadOnlyStatus()}'     "   readonly flag
  let statusline.='%#StatusLineNC#'         " - section 2
  let statusline.='%{ModifiedStatus()}'     "   modified flag
  let statusline.='%#StatusLineNC#'         " - section 3 
  let statusline.='%='                      "   blank space
  let statusline.=' %3l:%c  %-p%% '         "   lineinfo, percent
  let statusline.='%{SessionStatus()}'      "   session status
  let statusline.='%#StatusLineNC#'         " - section 4
  let statusline.='%{CurrentBranch()}'      "   git branch
  let l:coc_result = CocStatus()            "   coc status
  let statusline.= 
        \ (l:coc_result['total'] > 0 ? '%#Error#' : '%#MatchParen#') 
        \ . l:coc_result['str']
  return statusline
endfunction

function! InactiveStatus()
  let statusline='%#VertSplit#    '         " - section 0
  let statusline.='%f '                     "   filename
  let statusline.='%{ReadOnlyStatus()}'     "   readonly flag
  let statusline.='%{ModifiedStatus()}'     "   modified flag
  let statusline.='%='                      " - section 1
  let statusline.='%{SessionStatus()}'      "   session status
  let statusline.='%{CurrentBranch()}'      "   git branch
  let l:coc_result = CocStatus()            "   coc status
  let statusline.= 
        \ (l:coc_result['total'] > 0 ? '%#ErrorMsg#' : '%#VertSplit#') 
        \ . l:coc_result['str']
  return statusline
endfunction

augroup status
  autocmd!
  autocmd BufEnter,WinEnter * setlocal statusline=%!ActiveStatus()
  autocmd BufLeave,WinLeave * setlocal statusline=%!InactiveStatus()
augroup END
endif
