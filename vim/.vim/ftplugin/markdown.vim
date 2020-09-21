" Convert markdown to pdf using pandoc
command! -buffer MdToPdf execute '!pandoc % -o %:r.pdf && echo Created file: %:r.pdf'

nnoremap <buffer> <Leader>P :MdToPdf<cr>
