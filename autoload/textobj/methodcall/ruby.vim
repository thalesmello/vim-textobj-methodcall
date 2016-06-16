function! textobj#methodcall#ruby#current_indent()
   return getline('.') == '' ? cindent('.') : indent('.')
endfunction

function! textobj#methodcall#ruby#search_head(indent) "{{{
   while 1
      let line = search( '\<\%(do\)\>', 'bW' )
      if line == 0
         throw 'not found'
      endif

      let syntax = textobj#methodcall#ruby#syntax_from_block(expand('<cword>'))
      if syntax == ''
         throw 'not found'
      endif

      let current_indent = indent('.')
      if current_indent < a:indent && syntax ==# textobj#methodcall#ruby#syntax_highlight()
         return
      endif
   endwhile
endfunction

function! textobj#methodcall#ruby#syntax_from_block(block) "{{{
    for [syntax, names] in items({
                \   'rubyConditional' : ['if', 'unless', 'case'],
                \   'rubyRepeat'      : ['while', 'until', 'for'],
                \   'rubyModule'      : ['module'],
                \   'rubyClass'       : ['class'],
                \   'rubyControl'     : ['do', 'begin'],
                \   'rubyDefine'      : ['def'],
                \ })
        if index(names, a:block) >= 0
            return syntax
        endif
    endfor
    return ''
endfunction

function! textobj#methodcall#ruby#syntax_highlight()
    return synIDattr(synID(line('.'), col('.'), 1), 'name')
endfunction

function! textobj#methodcall#ruby#search_tail(head_indent, syntax)
    while 1
        let line = search( '\<end\>', 'We')
        if line == 0
            throw 'not found'
        endif

        if indent('.') == a:head_indent && a:syntax ==# textobj#methodcall#ruby#syntax_highlight()
            return getpos('.')
        endif
    endwhile
endfunction

function! textobj#methodcall#ruby#move_to_outer_scope()
   let indent = textobj#methodcall#ruby#current_indent()
   call textobj#methodcall#ruby#search_head(indent)
endfunction

function! textobj#methodcall#ruby#move_to_previous_method_call()
   silent! execute 'normal! ?\v(\.{0,1}\w+)+' . "\<cr>"
endfunction

function! textobj#methodcall#ruby#move_to_scope_head()
   let indent = textobj#methodcall#ruby#current_indent()
   call textobj#methodcall#ruby#search_head(indent + 1)
endfunction

function! textobj#methodcall#ruby#move_to_scope_tail()
   call search(s:get_scope_head())
   call textobj#methodcall#ruby#search_tail(indent('.'), 'rubyControl')
endfunction

function! textobj#methodcall#ruby#get_scope_head()
   return '\<do\>'
endfunction

function! textobj#methodcall#ruby#get_scope_tail()
   return '\<end\>'
endfunction