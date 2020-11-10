" cmake4vim settings

let g:cmake_build_dir = 'build'
let g:cmake_build_target = 'all'
let g:cmake_compile_commands = 1
let g:ctest_usr_args = '-V'

" WIP custom commands
"
" command! -nargs=? -complete=custom,cmake4vim#CompleteTarget CMakeBuildAndTest call cmake4vim#CMakeBuild('--target test')

" function! CTestOnly() abort
"   call cmake4vim#CMakeBuild('test')

"   let s:num_test_errors = len(filter(getqflist(), 'v:val.valid'))
"   if s:num_test_errors == 0
"     echo 'Tests passed!'
"   else
"     echo 'Tests failed!'
"   endif
" endfunction

" function! Test() abort
"   call cmake4vim#CMakeBuild('all')

"   let s:num_build_errors = len(filter(getqflist(), 'v:val.valid'))
"   if s:num_build_errors == 0
"     echo 'Build succeeded!'

"     call cmake4vim#CMakeBuild('test')

"     let s:num_test_errors = len(filter(getqflist(), 'v:val.valid'))
"     if s:num_test_errors == 0
"       echo 'Tests passed!'
"     endif
"   else
"     echo 'Build failed!'
"   endif

"   call cmake4vim#SelectTarget('all')
" endfunction

" command! CMakeBuildAndCTest call Test()
