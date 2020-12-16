"==============================================================================
" Lightline configuration
"------------------------------------------------------------------------------
let g:lightline = {}

"==============================================================================
" Component layout
"------------------------------------------------------------------------------
let g:lightline.active = {
      \ 'left':  [ [ 'mode', 'paste' ],
      \            [ 'readonly', 'relativepath', 'modified' ] ],
      \ 'right': [ [ 'linterstatus' ],
      \            [ 'gitbranch' ],
      \            [ 'obsessionstatus' ],
      \            [ 'filetypesymbol', 'lineinfo', 'percent' ] ] }

let g:lightline.inactive = {
      \ 'left':  [ [ 'readonly', 'relativepath', 'modified' ] ],
      \ 'right': [ [ 'linterstatus' ],
      \            [ 'gitbranch' ],
      \            [ 'obsessionstatus' ] ] }

let g:lightline.tabline = {
      \ 'left':  [ [ 'tabs' ] ],
      \ 'right': [ ] }

let g:lightline.enable = {
      \ 'statusline': 1,
      \ 'tabline': 0
      \ }

"==============================================================================
" Component functions
"------------------------------------------------------------------------------
function! FiletypeSymbol()
  return winwidth(0) > 70 ? (strlen(&filetype) ? WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

function! GitBranch()
  if exists('g:loaded_fugitive')
    let l:branch = fugitive#head()
    return fugitive#head() !=? '' ? (winwidth(0) < 100 ? ' ' . l:branch[0:15] : ' ' . l:branch) : ''
  endif
endfunction

function! LinterStatus() abort
  if exists('g:ale_enabled')
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_warnings = l:counts.total - l:all_errors
    return
          \ (l:all_errors > 0 ? printf('%dE', l:all_errors) : '') .
          \ (l:all_warnings > 0 ? printf('%dW', l:all_warnings) : '')
  endif
endfunction

function! SessionStatus() abort
  if exists('g:loaded_obsession')
    let l:status = ObsessionStatus()
    return l:status !=? '' ? (l:status ==? '[$]' ? '' : 'ﭸ') : ''
  endif
endfunction

let g:lightline.component_function = {
      \ 'filetypesymbol' : 'FiletypeSymbol',
      \ 'gitbranch' : 'GitBranch',
      \ 'linterstatus' : 'LinterStatus',
      \ 'obsessionstatus' : 'SessionStatus'
      \ }

let g:lightline.component_type = {
      \ 'linterstatus' : 'error' }

let g:lightline.component = {
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%<%f',
      \ 'filename': '%t',
      \ 'modified': '%{&modified?"":""}',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%{&readonly?"":""}',
      \ 'charvalue': '%b',
      \ 'charvaluehex': '%B',
      \ 'fileencoding': '%{&fenc!=#""?&fenc:&enc}',
      \ 'fileformat': '%{&ff}',
      \ 'filetype': '%{&ft!=#""?&ft:"no ft"}',
      \ 'percent': '%p%%',
      \ 'percentwin': '%P',
      \ 'spell': '%{&spell?&spelllang:""}',
      \ 'lineinfo': '%3l:%c',
      \ 'line': '%l',
      \ 'column': '%c',
      \ 'close': '%999X X ',
      \ 'winnr': '%{winnr()}' }

"==============================================================================
" Mode display names
"------------------------------------------------------------------------------
let g:lightline.mode_map = {
      \ 'n' : 'N',
      \ 'i' : 'I',
      \ 'R' : 'R',
      \ 'v' : 'V',
      \ 'V' : 'V-LINE',
      \ "\<C-v>": 'V-BLOCK',
      \ 'c' : 'COMMAND',
      \ 's' : 'SELECT',
      \ 'S' : 'S-LINE',
      \ "\<C-s>": 'S-BLOCK',
      \ 't': 'TERMINAL',
      \ }

"==============================================================================
" Separators
"------------------------------------------------------------------------------
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

"==============================================================================
" Color scheme
"------------------------------------------------------------------------------
let g:lightline.colorscheme = 'base16'

scriptencoding utf-8
