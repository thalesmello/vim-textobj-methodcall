function! textobj#methodcall#select_a()
   return textobj#methodcall#select('a')
endfunction

function! textobj#methodcall#select_i()
   return textobj#methodcall#select('i')
endfunction


function! textobj#methodcall#select(motion)
   if a:motion == 'a'
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

function! textobj#methodcall#select_chain_i()
   return textobj#methodcall#select_chain('i')
endfunction

function! textobj#methodcall#select_chain_a()
   return textobj#methodcall#select_chain('a')
endfunction

function! s:char_under_cursor()
    return getline('.')[col('.') - 1]
endfunction

function! textobj#methodcall#select_chain(motion)
   if a:motion == 'a'
      silent! normal! [(
   endif

   silent! execute 'normal! w?\v(\.{0,1}\w+)+' . "\<cr>"
   let head = getpos('.')
   while s:char_under_cursor() == '.'
      silent! execute "normal! ?)\<cr>%"
      silent! execute 'normal! w?\v(\.{0,1}\w+)+' . "\<cr>"
      let head = getpos('.')
   endwhile

   silent! execute "normal! %"
   let tail = getpos('.')
   silent! execute 'normal! /\v(\.{0,1}\w+)+' . "\<cr>"
   while s:char_under_cursor() == '.'
      silent! execute "normal! %"
      let tail = getpos('.')
      silent! execute 'normal! /\v(\.{0,1}\w+)+' . "\<cr>"
   endwhile
   call setpos('.', tail)

   if tail == head
      return 0
   endif

   return ['v', head, tail]
endfunction

