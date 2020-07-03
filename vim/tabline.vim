if exists("+showtabline")

  " Rename tabs to show tab number.
  " (Based on http://stackoverflow.com/questions/5927952/whats-implementation-of-vims-default-tabline-function)

  function! MyTabLine()
    let s = ''
    let t = tabpagenr()
    let i = 1
    while i <= tabpagenr('$')
      let buflist = tabpagebuflist(i)
      let winnr = tabpagewinnr(i)
      
      " let s .= '%' . i . 'T'

      " Set the active/inactive tab colors
      let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')

      " Tab left padding
      let s .= '  '

      " Show the tab number as a superscript
      let s .="%{GetSuperscript(".i.")}"

      let bufnr = buflist[winnr - 1]
      let file = bufname(bufnr)
      let buftype = getbufvar(bufnr, '&buftype')

      if buftype == 'help'
        let file = 'help:' . fnamemodify(file, ':t:r')

      elseif buftype == 'quickfix'
        let file = 'quickfix'

      elseif buftype == 'nofile'
        if file =~ '\/.'
          let file = substitute(file, '.*\/\ze.', '', '')
        endif

      else
        " Set the filename (no path)
        let file = pathshorten(fnamemodify(file, ':t'))

        " Set the modified flag (with color)
        if getbufvar(bufnr, '&modified')
          let file = file . '  ⚡'
          " let file = file . '%#CursorLineN#' . '  ⚡'
        endif

      endif

      if file == ''
        let file = '[No Name]'
      endif

      " Display the filename
      let s .= ' ' . file

      " Tab right padding
      let s .= '  '
      
      let i = i + 1

    endwhile

    let s .= '%T%#TabLineFill#%='
    " let s .= (tabpagenr('$') > 1 ? '%999XX' : 'X')
    return s

  endfunction

  set tabline=%!MyTabLine()

endif " exists("+showtabline")

" Borrowed from taboo.vim: https://github.com/gcmt/taboo.vim/blob/master/plugin/taboo.vim
function! GetSuperscript(number)
  let unicode_number = ""

  let small_numbers = ["⁰", "¹", "²", "³", "⁴", "⁵", "⁶", "⁷", "⁸", "⁹"]
  let number_str    = string(a:number)

  for i in range(0, len(number_str) - 1)
    let unicode_number .= small_numbers[str2nr(number_str[i])]
  endfor

  return unicode_number
endfunction

