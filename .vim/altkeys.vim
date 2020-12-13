" Fix meta-keys which generate <Esc>a .. <Esc>z
" Creates <A-a> .. <A-z> keys

"let c='a'
"while c <= 'z'
"	exec "set <A-".c.">=".c
"	exec "imap ".c." <A-".c.">"
"	let c = nr2char(1+char2nr(c))
"endw
"exec "imap [1;5P <C-F1>"
"exec "imap [21;5~ <C-F10>"

for ord in range(33,61)+range(63,90)+range(92,126)
	let char = ord is 34 ? '\"' : ord is 124 ? '\|' : nr2char(ord)
	exec printf("set <A-%s>=\<ESC>%s", char, char)
	if exists(':tnoremap') " fix terminal control sequences
		exec printf("tnoremap <silent> <A-%s> <ESC>%s", char, char)
	endif
endfor
"set <C-F1>=\<ESC>[1;5P
"set <C-F10>=\<ESC>[21;5~
imap [1;5P <C-F1>
imap [21;5~ <C-F10>
imap [21;3~ <A-F10>
set <C-Right>=\<ESC>[1;5C
set <C-Left>=\<ESC>[1;5D

