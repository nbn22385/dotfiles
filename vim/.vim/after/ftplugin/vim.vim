setlocal foldtext=CustomFold()

function! CustomFold()
  let folded_line_num = v:foldend - v:foldstart
  let line_text = substitute(getline(v:foldstart), '^" {\+\s', '', 'g')
  let fillcharcount = &textwidth - len(line_text) - len(folded_line_num)
  return '▶ ' . line_text . ' ' . repeat('·', fillcharcount) . ' (' . folded_line_num . ' lines)'
endfunction

scriptencoding utf-8
