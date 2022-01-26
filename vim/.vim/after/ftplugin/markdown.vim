" Enable syntax highlighting for code blocks
let markdown_fenced_languages = ['bash', 'cmake', 'cpp', 'sh']

" Convert the current markdown file to pdf using pandoc
command! -buffer MdToPdf execute '!pandoc % -o %:r.pdf && echo Created file: %:r.pdf'
nnoremap <buffer> <Leader>P :MdToPdf<cr>
