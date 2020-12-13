" File: joinlines.vim
" Author: Nicholas Christopoulos
" Version: 1.0
" Last Modified: 13 Dec 2020
"
" Overview
" --------
" The joinlines.vim Vim plugin reconfigures [backspace] and [delete] keys
" to automatic join lines when are pressed at begin or at the end of the line.

func! s:JBS()
	if col(".") <= 1
		if line(".") != 1
			normal k$Jx
		endif
	else
		normal X
	endif
endfunc
inoremap <silent> <BS> <C-O>:call <SID>JBS()<CR>

func! s:JDEL()
	if virtcol(".") != virtcol("$")
        normal x
	else
		normal Jx
	endif
endfunc
inoremap <silent> <DEL> <C-O>:call <SID>JDEL()<CR>
