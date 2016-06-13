call textobj#user#plugin('methodcall', {
         \ '-': {
         \   'select-a': 'am', 'select-a-function': 'textobj#methodcall#select_a',
         \   'select-i': 'im', 'select-i-function': 'textobj#methodcall#select_i',
         \ },
         \ 'chain': {
         \   'select-function': 'textobj#methodcall#select_chain',
         \   'select': ['aM', 'iM']
         \ }})

