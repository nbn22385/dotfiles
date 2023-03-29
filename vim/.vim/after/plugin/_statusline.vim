"==============================================================================
" Set statusline (with filetype overrides)
"------------------------------------------------------------------------------
augroup statusline
  autocmd!
  autocmd BufEnter,BufWinEnter,WinEnter * call SetStatusline()
augroup END

function! SetStatusline() abort
  let l:current = winnr()
  for win in range(1, winnr('$'))
    let l:filetype = getwinvar(win, '&filetype')
    call setwinvar(win, '&statusline', 
          \ l:filetype ==# 'coc-explorer' ? ' ' :
          \ l:filetype ==# 'qf' ? '%!QuickFixStatus()' :
          \ l:filetype =~# '^fugitive' ? l:filetype :
          \ win == l:current ? '%!ActiveStatus()' : '%!InactiveStatus()')
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
  let s.=' %3l:%c  %-p%% %{Bars()} '   "   lineinfo, percent
  let s.='%#Todo#%{SessionStatus()}'   "   session status
  let s.='%#StatusLineMagenta#'        " - section 5
  let s.='%{CurrentBranch()}'          "   git branch
  let s.='%#StatusLine#'               " - section 6
  let s.=CocStatus()                   "   coc diagnostic info
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
  let s.='%{CurrentBranch()}'          "   git branch
  return s
endfunction

"==============================================================================
" QuickFix layout
"------------------------------------------------------------------------------
function! QuickFixStatus() abort
  let s='%#StatusLineBlue#'
  let s=' Quickfix List '
  let s.= "[%l/" . len(getqflist()) . "]"
  let s.=' %{Bars()} '
  return s
endfunction

"==============================================================================
" Helper functions
"------------------------------------------------------------------------------
function! CurrentMode() abort
  let l:cmd = getcmdtype()
  if l:cmd ==? ''
    return toupper(get(g:currentmode, mode(), '???')) 
          \ . (&paste == 1 ? '-PASTE' : '')
  else
    return get(g:cmdtypes, l:cmd, '')
  endif
endfunction

function! CurrentBranch() abort
  if winwidth(0) <= 50
    return ''
  endif
  if exists('g:loaded_fugitive')
    let l:branch = FugitiveHead()
    return l:branch !=? '' ? (winwidth(0) < 80 ? '  ' . l:branch[0:15] . ' ' : 
          \ '  ' . l:branch . ' ') : ''
  else
    return ''
  endif
endfunction

function! CocStatus() abort
  let info = get(b:, 'coc_diagnostic_info', {})
  if empty(info) | return '' | endif
  let msgs = []
  if get(info, 'error', 0)
    call add(msgs, '%#StatusLineRed#× ' . info['error'])
  endif
  if get(info, 'warning', 0)
    call add(msgs, '%#StatusLineYellow# ' . info['warning'])
  endif
  if empty(msgs) | return '%#StatusLineGreen#  ' | endif
  return ' ' . join(msgs, ' ') . ' '
endfunction

function! ModifiedStatus() abort
  return &modified ==? 'nmodified' ? '' : '  '
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
    return l:status !=? 'OFF' ? l:status : ''
  else
    return ''
  endif
endfunction

function! SpellStatus() abort
  return &spell ? 'SPELL' : ''
endfunction

function! Bars() abort
  let l:current_line = line('.')
  let l:total_lines = line('$')
  let l:chars = [ '', '█', '▇', '▆', '▅', '▄', '▃', '▂', '▁']
  let l:line_ratio = 1.0 * l:current_line / l:total_lines
  let l:index = float2nr(ceil(l:line_ratio * (len(chars)-1)))
  return chars[l:index]
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
      \ 'no'     : '%#StatusLineWhite#',
      \ 's'      : '%#StatusLineWhite#',
      \ 'S'      : '%#StatusLineWhite#',
      \ "\<C-S>" : '%#StatusLineWhite#',
      \ 'R'      : '%#StatusLineRed#',
      \ 'Rv'     : '%#StatusLineRed#',
      \ 'c'      : '%#StatusLineGreen#',
      \ 'cv'     : '%#StatusLineWhite#',
      \ 'ce'     : '%#StatusLineWhite#',
      \ 'r'      : '%#StatusLineYellow#',
      \ 'rm'     : '%#StatusLineYellow#',
      \ 'r?'     : '%#StatusLineYellow#',
      \ '!'      : '%#StatusLineOrange#',
      \ 'ic'     : '%#StatusLineWhite#',
      \ 'Rc'     : '%#StatusLineWhite#'}

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

scriptencoding utf-8
