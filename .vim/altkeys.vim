" Fix meta-keys which generate <Esc>a .. <Esc>z
" Creates <A-a> .. <A-z> keys

let c='a'
while c <= 'z'
	exec "set <A-".c.">=".c
	exec "set <A-".toupper(c).">=".toupper(c)
	exec "imap ".c." <A-".c.">"
	exec "imap ".toupper(c)." <A-".toupper(c).">"
	let c = nr2char(1+char2nr(c))
endw

