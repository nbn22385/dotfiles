if 0
"==============================================================================
" Component layout
"------------------------------------------------------------------------------
let g:lightline = {}

let g:lightline.active = {
      \ 'left':  [ [ 'mode', 'paste' ], 
      \            [ ],
      \            [ 'readonly', 'relativepath', 'modified' ] ],
      \ 'right': [ [ ],
      \            [ ],
      \            [ 'coc_errors', 'coc_warnings', 'coc_ok', 
      \              'lineinfo', 'percent', 'obsessionstatus', 'gitbranch' ] ] 
      \ }

let g:lightline.inactive = {
      \ 'left':  [ [ 'readonly', 'relativepath', 'modified' ] ],
      \ 'right': [ ] 
      \ }

let g:lightline.tabline = {
      \ 'left':  [ [ 'tabs' ] ],
      \ 'right': [ ] 
      \ }

let g:lightline.enable = {
      \ 'statusline': 1,
      \ 'tabline': 0
      \ }

"==============================================================================
" Component functions
"------------------------------------------------------------------------------
" call lightline#coc#register()
let g:lightline.component_expand = {
      \   'coc_warnings': 'lightline#coc#warnings',
      \   'coc_errors': 'lightline#coc#errors',
      \   'coc_info': 'lightline#coc#info',
      \   'coc_hints': 'lightline#coc#hints',
      \   'coc_ok': 'lightline#coc#ok',
      \   'status': 'lightline#coc#status',
      \ }

" Define all coc components to customize coc_ok color
let g:lightline.component_type = {
      \   'coc_warnings': 'warning',
      \   'coc_errors': 'error',
      \   'coc_info': 'info',
      \   'coc_hints': 'hints',
      \   'coc_ok': 'middle',
      \ }

function! LightlineMode() abort
  let ftmap = {
        \ 'coc-explorer': 'EXPLORER',
        \ 'fugitive': 'FUGITIVE'
        \ }
  return get(ftmap, &filetype, lightline#mode())
endfunction

function! GitBranch()
  if winwidth(0) <= 50
    return ''
  endif
  if get(g:,'coc_enabled')
    let l:branch = get(g:, 'coc_git_status', '')
    return l:branch !=? '' ? (winwidth(0) < 100 ? l:branch[0:15] : l:branch) : ''
  elseif exists('g:loaded_fugitive')
    let l:branch = fugitive#head()
    return l:branch !=? '' ? (winwidth(0) < 100 ? ' ' . l:branch[0:15] : ' ' . l:branch) : ''
  endif
endfunction

function! SessionStatus() abort
  if winwidth(0) <= 50
    return ''
  endif
  if exists('g:loaded_obsession')
    let l:status = ObsessionStatus('', 'OFF')
    return l:status != 'OFF' ? l:status : ''
  else
    return ''
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
" Colorscheme
"------------------------------------------------------------------------------
let g:lightline.colorscheme = 'base16'

endif
