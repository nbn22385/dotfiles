" lightline stuff
scriptencoding utf-8

let g:lightline = {}

let g:lightline.enable = {
      \ 'statusline': 1,
      \ 'tabline': 0
      \ }

function! CurrentBranch()
  if exists('g:loaded_fugitive')
    let l:branch = fugitive#head()
    return fugitive#head() !=? '' ? (winwidth(0) < 100 ? '  ' . l:branch[0:15] : '  ' . l:branch) : ''
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

function! ModifiedFlag()
  return &modified ? '●' : ''
endfunction

let g:lightline.component_function = {
      \ 'gitbranch': 'CurrentBranch',
      \ 'modifiedflag': 'ModifiedFlag',
      \ 'linterstatus' : 'LinterStatus'
      \ }

" let g:lightline.colorscheme = 'base16'

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

let g:lightline.separator = { 'left': '', 'right': '' }
let g:lightline.subseparator = { 'left': '', 'right': '' }

let g:lightline.active = {
      \ 'left': [ [ 'mode', 'paste' ],
      \           [ 'readonly', 'filename', 'modifiedflag' ] ],
      \ 'right': [ ['linterstatus'], [ 'gitbranch'],
      \            [ 'lineinfo' ,
      \             'percent' ] ] }
let g:lightline.inactive = {
      \ 'left': [ [ 'filename' ] ],
      \ 'right': [ [ 'lineinfo' ],
      \            [ 'percent' ] ] }
let g:lightline.tabline = {
      \ 'left': [ [ 'tabs' ] ],
      \ 'right': [ [ 'close' ] ] }
