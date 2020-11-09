" general settings
let g:ale_enabled = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '●'
let g:ale_set_balloons = 1

" completion
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
let g:ale_completion_max_suggestions = 10
set completeopt=menu,menuone,preview,noinsert

augroup AleCompletion
  autocmd!
  autocmd FileType cpp,vim setlocal omnifunc=ale#completion#OmniFunc
  autocmd FileType cpp setlocal signcolumn=yes
augroup END

" linting
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_linters_explicit = 1
let g:ale_linters = { 'cpp': ['clangd'], 'vim': ['vimls', 'vint']}
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_clangd_options = '--clang-tidy --clang-tidy-checks="-*"'

" fixing
let g:ale_fixers  = { 'cpp': ['clang-format'], 'vim': ['trim_whitespace','remove_trailing_lines'],}
let g:ale_fix_on_save = 1

" custom colors
hi link ALEError Error
hi link ALEErrorSign ErrorMsg

" mappings
nnoremap K :ALEGoToDefinition<cr>
" Ctrl-Space to open omnicomplete popup
inoremap <C-@> <c-x><c-o>
" Enter will select the highlighted popup item
" source: https://vim.fandom.com/wiki/Make_Vim_completion_popup_menu_work_just_like_in_an_IDE
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
