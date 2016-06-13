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

function! textobj#methodcall#select_chain()
   silent! execute 'normal ?\v([^.]&\W)\zs\w+((\.{0,1}\w+)*\((\(([^()]|\n)*\)|([^()]|\n)*){-}\)(\_s)*)+' . "\<cr>"
   let head = getpos('.')
   silent! execute 'normal //e' . "\<cr>"
   let tail = getpos('.')
   if tail == head
      return 0
   endif
   return ['v', head, tail]
endfunction
