function! textobj#methodcall#select_a()
   return textobj#methodcall#select('a')
endfunction

function! textobj#methodcall#select_i()
   return textobj#methodcall#select('i')
endfunction

function! textobj#methodcall#select(mode)
   if a:mode == 'a'
      silent! normal! [(
   endif
   silent! execute "normal! w?\\v(\\.{0,1}\\w+)+\<cr>"
   let head_pos = getpos('.')
   normal! %
   let tail_pos = getpos('.')
   if tail_pos == head_pos
      return 0
   endif
   return ['v', head_pos, tail_pos]
endfunction

