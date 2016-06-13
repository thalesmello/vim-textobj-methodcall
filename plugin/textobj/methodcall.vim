call textobj#user#plugin('methodcall', {
         \ '-': {
         \   'select-a': 'am', 'select-a-function': 'textobj#methodcall#select_a',
         \   'select-i': 'im', 'select-i-function': 'textobj#methodcall#select_i',
         \ },
         \ 'chain': {
         \   'select-a': 'aM', 'select-a-function': 'textobj#methodcall#select_chain_a',
         \   'select-i': 'iM', 'select-i-function': 'textobj#methodcall#select_chain_i'
         \ }})

