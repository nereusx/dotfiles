" Fix meta-keys which generate <Esc>a .. <Esc>z
" Creates <A-a> .. <A-z> keys

let c='a'
while c <= 'z'
	exec "set <A-".c.">=".c
	exec "imap ".c." <A-".c.">"
	let c = nr2char(1+char2nr(c))
endw

