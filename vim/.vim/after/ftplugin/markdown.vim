" Enable syntax highlighting for code blocks
let markdown_fenced_languages = ['bash', 'cmake', 'cpp', 'python', 'sh', 'vim', 'yaml']

" Convert the current markdown file to pdf using pandoc
set makeprg=pdflatex\ '%'\ -o\ %:r.pdf\ &&\ echo\ Created\ file:\ %:r.pdf
