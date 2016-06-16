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
