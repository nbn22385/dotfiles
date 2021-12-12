"==============================================================================
" Set statusline (with filetype overrides)
"------------------------------------------------------------------------------
set statusline=%!ActiveStatus()

augroup status
  autocmd!
  autocmd WinEnter,BufEnter,SessionLoadPost,FileChangedShellPost * call GetStatusline()
augroup END

function! GetStatusline() abort
  let l:current = winnr()
  for win in range(1, winnr('$'))
    let l:filetype = getwinvar(win, '&filetype')
    call setwinvar(win, '&statusline', 
          \ l:filetype ==# 'coc-explorer' ? ' ' :
          \ l:filetype =~# '^fugitive' ? l:filetype :
          \ l:filetype ==# 'minimap' ? ' ' : 
          \ win == l:current ? ActiveStatus() : InactiveStatus())
  endfor
endfunction

"==============================================================================
" Active layout
"------------------------------------------------------------------------------
function! ActiveStatus() abort
  let s =get(g:modecolors, mode(), '%#StatusLine#') " - section 0
  let s.=' %{CurrentMode()} %<'        "   mode
  let s.='%#StatusLine#'               " - section 1
  let s.=' %f'                         "   filename
  let s.='%{ReadOnlyStatus()}'         "   readonly flag
  let s.='%#TabLineSel#'               " - section 2
  let s.='%{ModifiedStatus()}'         "   modified flag
  let s.='%#StatusLine#'               " - section 3 
  let s.='%='                          "   blank space
  let s.='%#Todo#%{SpellStatus()}'     "   spell checking status
  let s.='%#StatusLine#'               " - section 4
  let s.=' %3l:%c  %-p%% '             "   lineinfo, percent
  let s.='%#Todo#%{SessionStatus()}'   "   session status
  let s.='%#StatusLineMagenta#'        " - section 5
  let s.='%{CurrentBranch()}'          "   git branch
  let s.='%#StatusLine#'               " - section 6
  let l:coc_result = CocErrors()       "   coc diagnostic info
  let s.= 
        \ (l:coc_result['total'] > 0 ? '%#StatusLineRed#' : '%#StatusLineGreen#') 
        \ . l:coc_result['str']
  return s
endfunction

"==============================================================================
" Inactive layout
"------------------------------------------------------------------------------
function! InactiveStatus() abort
  let s='%#StatusLineNC#    '          " - section 0
  let s.='%f'                          "   filename
  let s.='%{ReadOnlyStatus()}'         "   readonly flag
  let s.='%{ModifiedStatus()}'         "   modified flag
  let s.='%='                          " - section 1
  return s
endfunction

"==============================================================================
" Helper functions
"------------------------------------------------------------------------------
function! CurrentMode() abort
  let l:cmd = getcmdtype()
  if l:cmd == ''
    return toupper(get(g:currentmode, mode(), '???')) . (&paste == 1 ? '-PASTE' : '')
  else
    return get(g:cmdtypes, l:cmd, '')
  endif
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
    let l:status = ObsessionStatus('   ', 'OFF')
    return l:status != 'OFF' ? l:status : ''
  else
    return ''
  endif
endfunction

function! SpellStatus() abort
  return &spell ? 'SPELL' : ''
endfunction

"==============================================================================
" Mode to color mappings
"------------------------------------------------------------------------------
let g:modecolors = {
      \ 'n'      : '%#StatusLineBlue#',
      \ 'i'      : '%#StatusLineYellow#',
      \ 'v'      : '%#StatusLineMagenta#',
      \ 'V'      : '%#StatusLineMagenta#',
      \ "\<C-V>" : '%#StatusLineMagenta#',
      \ 't'      : '%#StatusLineGreen#',
      \ 'no'     : '%#DiffChange#',
      \ 's'      : '%#WildMenu#',
      \ 'S'      : '%#WildMenu#',
      \ "\<C-S>" : '%#WildMenu#',
      \ 'R'      : '%#StatusLineRed#',
      \ 'Rv'     : '%#Error#',
      \ 'c'      : '%#StatusLineGreen#',
      \ 'cv'     : '%#MatchParen#',
      \ 'ce'     : '%#MatchParen#',
      \ 'r'      : '%#Todo#',
      \ 'rm'     : '%#Todo#',
      \ 'r?'     : '%#Todo#',
      \ '!'      : '%#IncSearch#',
      \ 'ic'     : '%#DiffChange#',
      \ 'Rc'     : '%#DiffChange#'}

"==============================================================================
" Mode to modestring mappings
"------------------------------------------------------------------------------
let g:currentmode = {
      \ 'n'      : 'N',
      \ 'i'      : 'I',
      \ 'v'      : 'V',
      \ 'V'      : 'L',
      \ "\<C-V>" : 'B',
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

"==============================================================================
" Command to icon mappings
"------------------------------------------------------------------------------
let g:cmdtypes = {
      \ ':'      : '',
      \ '/'      : '',
      \ '?'      : ''}

