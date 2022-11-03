" Enable syntax highlighting for code blocks
let markdown_fenced_languages = ['bash', 'cmake', 'cpp', 'python', 'sh', 'vim']

" Convert the current markdown file to pdf using pandoc
set makeprg=pandoc\ '%'\ -o\ %:r.pdf\ &&\ echo\ Created\ file:\ %:r.pdf
