" File: cbuflist.vim
" Author: Nicholas Christopoulos
" Version: 1.0
" Last Modified: 17 Dec 2020
"
" Overview
" --------
" Advanced buffer list popup window using the quickui.
" 

" prevent to load again
if exists('g:loaded_cbuflist')
    finish
endif
let g:loaded_cbuflist = v:true
let s:bids = []
let s:idx2bid = []

" list buffer ids
func! s:makebids()
    redir => buflist
    silent! ls
    redir END
    let s:bids = []
    for curline in split(buflist, '\n')
        if curline =~ '^\s*\d\+'
			call add(s:bids, str2nr(matchstr(curline, '^\s*\zs\d\+')))
        endif
    endfor
endfunc

" create item entry (the buffer line)
func! s:citem(bid)
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
func! cbuflist#popselect(id, result)
	if a:result > 0
		let bid = s:idx2bid[a:result-1]
		silent! execute printf('b%d', bid)
		redraw
		echo 'File: ' . bufname(bid)
	endif
endfunc

func! cbuflist#popfilter(id, key)
	" Handle shortcuts
	if a:key == 'q' || a:key == 'x' " close
		call popup_close(a:id)
		return 1
	endif
"	if a:key == 'e' " edit
"		call popup_close(a:id, 1)
"		return 1
"	endif
	if a:key == 'w' " write buffer, need refresh
		return 1
	endif
	if a:key == 'd' || a:key == "\<DEL>" " delete buffer, need refresh
		return 1
	endif
	if a:key == 'r' " reload buffer
		return 1
	endif
"	if a:key == 'e'
"		exec 'b '. a:bid
"	elseif a:key == 'v'
"		exec 'vs'
"		exec 'b '. a:bid
"	elseif code == 's'
"		exec 'split'
"		exec 'b '. a:bid

	" No shortcut, pass to generic filter
	return popup_filter_menu(a:id, a:key)
endfunc

" get content
func! cbuflist#buflist()
	call s:makebids()
	let s:idx2bid = []
	let content = []
	let index = 0
	for bid in s:bids
		let buftype = getbufvar(bid, '&buftype')
		if buftype == 'nofile' || buftype == 'quickfix' || buftype == 'popup'
			continue
		endif
		call add(content, s:citem(bid))
		call add(s:idx2bid, bid)
		let index += 1
	endfor
	let opts = {
		\ 'title':    ' Buffer List ',
		\ 'filter':   'cbuflist#popfilter',
		\ 'callback': 'cbuflist#popselect' }
	if len(content)
		redraw
		echo "ENTER: select, (s)plit, (v)split, (w)rite, (d)elete, (r)eload"
		call popup_menu(content, opts)
	else
		redraw
		echom "*** the buffer list is empty! ***"
	endif
endfunc

