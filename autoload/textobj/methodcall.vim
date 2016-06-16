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
   call s:syntax_motion('move_to_outer_scope')
endfunction

function! s:move_to_previous_method_call()
   call s:syntax_motion('move_to_previous_method_call')
endfunction

function! s:move_to_previous_scope_tail()
   call search(s:get_scope_tail(), 'bW')
endfunction

function! s:move_to_scope_head()
   call s:syntax_motion('move_to_scope_head')
endfunction

function! s:move_to_scope_tail()
   call s:syntax_motion('move_to_scope_tail')
endfunction
command! MoveScopeTail call s:move_to_scope_tail()

function! s:get_scope_head()
   call s:syntax_motion('get_scope_head')
endfunction

function! s:get_scope_tail()
   call s:syntax_motion('get_scope_tail')
endfunction

let s:custom_syntax_motions = ['ruby']
function! s:syntax_motion(method)
   if index(s:custom_syntax_motions, &filetype) >= 0
      call textobj#methodcall#{&filetype}#{a:method}()
   else
      call textobj#methodcall#default#{a:method}()
   endif
endfunction
