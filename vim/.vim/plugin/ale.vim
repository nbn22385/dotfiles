" general settings
let g:ale_enabled = 1
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '●'

" completion
let g:ale_completion_enabled = 1
let g:ale_completion_autoimport = 1
set completeopt=menu,menuone,preview,noselect,noinsert
autocmd FileType cpp setlocal omnifunc=ale#completion#OmniFunc
autocmd FileType cpp setlocal signcolumn=yes 

" c++ linting/fixing
let g:ale_linters_explicit = 1
let g:ale_linters = { 'cpp': ['clangd'],}
let g:ale_fixers  = { 'cpp': ['clang-format'], 'vim': ['trim_whitespace'],}
let g:ale_fix_on_save = 1
let g:ale_c_parse_compile_commands = 1
let g:ale_cpp_clangd_options = '--clang-tidy --clang-tidy-checks="-*"'