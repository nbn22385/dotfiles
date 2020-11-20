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
      \            [ 'lineinfo', 'percent' ] ] }
let g:lightline.inactive = {
      \ 'left':  [ [ 'relativepath' ] ],
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
function! CurrentBranch()
  if exists('g:loaded_fugitive')
    let l:branch = fugitive#head()
    return fugitive#head() !=? '' ? (winwidth(0) < 100 ? ' ' . l:branch[0:15] : ' ' . l:branch) : ''
  else
    return ''
  endif
endfunction

function! LinterStatus() abort
  if exists('g:ale_enabled')
    let l:a = ''
    let l:counts = ale#statusline#Count(bufnr(''))
    let l:all_errors = l:counts.error + l:counts.style_error
    let l:all_non_errors = l:counts.total - l:all_errors
    return l:counts.total == 0 ? '' : printf(' %dW %dE ', all_non_errors, all_errors)
    " return l:counts.total == 0 ? '' : printf(' ✗%d ', all_errors)
  else
    return ''
  endif
endfunction

let g:lightline.component_function = {
      \ 'gitbranch': 'CurrentBranch',
      \ 'linterstatus' : 'LinterStatus',
      \ 'obsessionstatus' : 'ObsessionStatus'
      \ }

let g:lightline.component = {
      \ 'mode': '%{lightline#mode()}',
      \ 'absolutepath': '%F',
      \ 'relativepath': '%<%f',
      \ 'filename': '%t',
      \ 'modified': '%{&modified?"●":""}',
      \ 'bufnum': '%n',
      \ 'paste': '%{&paste?"PASTE":""}',
      \ 'readonly': '%R',
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
" extract the current base16 theme and set the corresponding lightline theme
let s:base16_shell_theme = substitute(substitute(system("grep colorscheme ~/.vimrc_background | awk -F ' ' '{print $2}'"), '\n', '', 'g'), '-', '_', 'g')
let g:lightline.colorscheme = s:base16_shell_theme

scriptencoding utf-8
