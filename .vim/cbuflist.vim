" File: cbuflist.vim
" Author: Nicholas Christopoulos
" Version: 1.0
" Last Modified: 17 Dec 2020
"
" Overview
" --------
" Advanced buffer list popup window using the quickui.
" This is part of 'cbrief' project.
"
" Required:
"	vim-quickui

if exists('g:loaded_cbuflist')
	finish
endif
let g:loaded_cbuflist = v:true

" list of buffer ids
func! s:make_bids()
    redir => buflist
    silent! ls
    redir END
    let bids = []
    for curline in split(buflist, '\n')
        if curline =~ '^\s*\d\+'
			call add(bids, str2nr(matchstr(curline, '^\s*\zs\d\+')))
        endif
    endfor
	return bids
endfunc

" create item entry (the buffer line)
func! s:make_item(bid)
	let name = fnamemodify(bufname(a:bid), ':p')
	let base = fnamemodify(name, ':t')
	let path = fnamemodify(name, ':h')
	let buftype = getbufvar(a:bid, '&buftype')
	let bufmod  = getbufvar(a:bid, '&modified')
	if bufmod
		let base = base . '*'
	endif
	return printf('#%d %-32s %s/', a:bid, base, path)
endfunc

" on-close
func! cbuflist#popselect(bid)
	let code = g:quickui#listbox#current.tag

	if a:bid 	
		if code == '' || code == 'e'
			exec printf('b%d', a:bid)
		elseif code == 's'
			exec 'sp'
			exec printf('b%d', a:bid)
		elseif code == 'v'
			exec 'vs'
			exec printf('b%d', a:bid)
		elseif code == 'w'
		elseif code == 'd'
		elseif code == 'R'
		elseif code == 'q'
		endif
"		echom printf('Switch to: "%s"', bufname(a:bid))
	endif
endfunc

" build and run...
func! cbuflist#buflist()
	let bids = s:make_bids()
	let content = []
	let ccount = 0
	let curbid = bufnr()
	let current = -1
	for bid in bids
		let buftype = getbufvar(bid, '&buftype')
		if buftype == 'nofile' || buftype == 'quickfix' || buftype == 'popup'
			continue
		endif
		let cmd = printf('call cbuflist#popselect(%d)', bid)
		let content += [[s:make_item(bid), cmd]]
		if bid == curbid
			let current = ccount
		endif
		let ccount += 1
	endfor

	let opts = {
		\ 'title': 'Buffer List',
		\ 'index': current,
        \ 'close': 'button',
		\ 'callback': 'cbuflist#popselect'
		\ }
	
	let opts.border = g:quickui#style#border
	let opts.keymap = {}
	let opts.keymap["e"] = 'TAG:e'
	let opts.keymap["s"] = 'TAG:s'
	let opts.keymap["v"] = 'TAG:v'
	let opts.keymap["w"] = 'TAG:w'
	let opts.keymap["d"] = 'TAG:d'
	let opts.keymap["\<DEL>"] = 'TAG:d'
	let opts.keymap["R"] = 'TAG:r'
	let opts.keymap["q"] = 'TAG:q'

	let hwnd = -1
	if len(content)
		redraw
		echo "ENTER: select, (e)dit, (s)plit, (v)split, (w)rite, (d)elete, (R)eload, (q)uit"
        let hwnd = quickui#listbox#open(content, opts)
	else
		redraw
		echom "*** the buffer list is empty! ***"
	endif
	return hwnd
endfunc

