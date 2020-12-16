"==============================================================================
" General settings
"------------------------------------------------------------------------------
scriptencoding utf-8

let g:ale_enabled = 1

"==============================================================================
" Style
"------------------------------------------------------------------------------
let g:ale_sign_error = '✘'
let g:ale_sign_warning = '◬'

"==============================================================================
" Completion
"------------------------------------------------------------------------------
let g:ale_completion_enabled = 0
let g:ale_completion_autoimport = 1
let g:ale_completion_max_suggestions = 10
set completeopt=menu,menuone,noinsert

augroup AleCompletion
  autocmd!
  autocmd FileType cpp,vim setlocal omnifunc=ale#completion#OmniFunc
  autocmd FileType cpp,vim setlocal signcolumn=yes
augroup END

"==============================================================================
" Linting
"------------------------------------------------------------------------------
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_linters_explicit = 1
let g:ale_linters = { 'cpp': ['clangd'], 'vim': ['vimls', 'vint']}
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_clangd_options = '--clang-tidy --clang-tidy-checks="-*"'

"==============================================================================
" Fixing
"------------------------------------------------------------------------------
let g:ale_fixers  = { 'cpp': ['clang-format'], 'vim': ['trim_whitespace','remove_trailing_lines'],}
let g:ale_fix_on_save = 1

"==============================================================================
" Mappings
"------------------------------------------------------------------------------
imap <buffer> <LocalLeader><Space> <Plug>(ale_complete)
nmap <buffer> <LocalLeader>gd <Plug>(ale_go_to_definition)
nmap <buffer> <LocalLeader>fr <Plug>(ale_find_references)
nmap <buffer> <LocalLeader>re <Plug>(ale_rename)

" Enter will select the highlighted popup item
" source: https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
