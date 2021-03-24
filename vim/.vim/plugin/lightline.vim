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
      \ 'right': [ [ 'coc_errors', 'coc_warnings', 'coc_ok' ],
      \            [ 'gitbranch' ],
      \            [ 'obsessionstatus' ],
      \            [ 'lineinfo', 'percent' ] ] }

let g:lightline.inactive = {
      \ 'left':  [ [ 'readonly', 'relativepath', 'modified' ] ],
      \ 'right': [ [ 'gitbranch' ],
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
call lightline#coc#register()

function! LightlineMode() abort
  let ftmap = {
        \ 'coc-explorer': 'EXPLORER',
        \ 'fugitive': 'FUGITIVE'
        \ }
  return get(ftmap, &filetype, lightline#mode())
endfunction

function! GitBranch()
  if winwidth(0) <= 30
    return ''
  endif
  if exists('g:loaded_fugitive')
    let l:branch = fugitive#head()
    return l:branch !=? '' ? (winwidth(0) < 100 ? ' ' . l:branch[0:15] : ' ' . l:branch) : ''
  endif
endfunction

function! SessionStatus() abort
  if winwidth(0) <= 30
    return ''
  endif
  if exists('g:loaded_obsession')
    let l:status = ObsessionStatus()
    return l:status !=? '' ? (l:status ==? '[$]' ? '' : 'ﭸ') : ''
  endif
endfunction

let g:lightline.component_function = {
      \ 'mode' : 'LightlineMode',
      \ 'filetypesymbol' : 'FiletypeSymbol',
      \ 'gitbranch' : 'GitBranch',
      \ 'obsessionstatus' : 'SessionStatus'
      \ }

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
      \ 't': 'T',
      \ }

"==============================================================================
" Separators
"------------------------------------------------------------------------------
let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

"==============================================================================
" Color scheme
"------------------------------------------------------------------------------
let g:lightline.colorscheme = 'gruvbox8'

scriptencoding utf-8
