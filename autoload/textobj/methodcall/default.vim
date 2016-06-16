function! textobj#methodcall#default#move_to_outer_scope()
   normal! [(
endfunction

function! textobj#methodcall#default#move_to_previous_method_call()
   silent! execute 'normal! w?\v(\.{0,1}\w+)+' . "\<cr>"
endfunction

function! textobj#methodcall#default#move_to_scope_head()
   normal! %
endfunction

function! textobj#methodcall#default#move_to_scope_tail()
   normal! %
endfunction

function! textobj#methodcall#default#get_scope_head()
   return '\<(\>'
endfunction

function! textobj#methodcall#default#get_scope_tail()
   return '\<)\>'
endfunction
