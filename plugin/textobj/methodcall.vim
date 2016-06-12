call textobj#user#plugin('methodcall', {
         \ '-': {
         \   'select-a': 'am', 'select-a-function': 'textobj#methodcall#select_a',
         \   'select-i': 'im', 'select-i-function': 'textobj#methodcall#select_i',
         \ },
         \ 'chain': {
         \   'pattern': '\v([^.]&\W)\zs\w+((\.{0,1}\w+)*\((\(([^()]|\n)*\)|([^()]|\n)*){-}\)(\_s)*)+',
         \   'select': ['aM', 'iM']
         \ }})
