function! textobj#methodcall#select_a()
   return textobj#methodcall#select('a')
endfunction

function! textobj#methodcall#select_i()
   return textobj#methodcall#select('i')
endfunction

function! textobj#methodcall#select(motion)
   if a:motion == 'a'
      silent! call s:move_to_outer_scope()
   endif

   silent! call s:move_to_previous_method_call()
   let head_pos = getpos('.')
   call s:move_to_scope_tail()
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
      silent! call s:move_to_outer_scope()
   endif
   silent! call s:move_to_previous_method_call()
   let head = getpos('.')
   while s:char_under_cursor() == '.'
      silent! call s:move_to_previous_scope_tail()
      silent! call s:move_to_scope_head()
      silent! call s:move_to_previous_method_call()
      let head = getpos('.')
   endwhile

   silent! call s:move_to_scope_tail()
   let tail = getpos('.')
   silent! execute 'normal! /\v(\.{0,1}\w+)+' . "\<cr>"
   while s:char_under_cursor() == '.'
      silent! call s:move_to_scope_tail()
      let tail = getpos('.')
      silent! execute 'normal! /\v(\.{0,1}\w+)+' . "\<cr>"
   endwhile
   call setpos('.', tail)

   if tail == head
      return 0
   endif

   return ['v', head, tail]
endfunction

function! s:move_to_outer_scope()
   if &filetype == 'ruby'
      let indent = textobj#methodcall#ruby#current_indent()
      call textobj#methodcall#ruby#search_head(indent)
   else
      normal! [(
   endif
endfunction

function! s:move_to_previous_method_call()
   if &filetype == 'ruby'
      silent! execute 'normal! ?\v(\.{0,1}\w+)+' . "\<cr>"
   else
      silent! execute 'normal! w?\v(\.{0,1}\w+)+' . "\<cr>"
   endif
endfunction

function! s:move_to_previous_scope_tail()
   call search(s:get_scope_tail(), 'bW')
endfunction

function! s:move_to_scope_head()
   if &filetype == 'ruby'
      let indent = textobj#methodcall#ruby#current_indent()
      call textobj#methodcall#ruby#search_head(indent + 1)
   else
      normal! %
   endif
endfunction

function! s:move_to_scope_tail()
   if &filetype == 'ruby'
      call search(s:get_scope_head())
      call textobj#methodcall#ruby#search_tail(indent('.'), 'rubyControl')
   else
      normal! %
   endif
endfunction
command! MoveScopeTail call s:move_to_scope_tail()

function! s:get_scope_head()
   if &filetype == 'ruby'
      return '\<do\>'
   else
      return '\<(\>'
   endif
endfunction

function! s:get_scope_tail()
   if &filetype == 'ruby'
      return '\<end\>'
   else
      return '\<)\>'
   endif
endfunction
