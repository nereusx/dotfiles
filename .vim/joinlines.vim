" File: joinlines.vim
" Author: Nicholas Christopoulos
" Version: 1.0
" Last Modified: 13 Dec 2020
"
" Overview
" --------
" The joinlines.vim Vim plugin reconfigures [backspace] and [delete] keys
" to automatic join lines when are pressed at begin or at the end of the line.
"

" prevent to load again
if exists('g:loaded_joinlines')
    finish
endif
let g:loaded_joinlines = v:true

func! s:JoinLinesBS()
	if col(".") <= 1 " begin of line
		if line(".") != 1 " not begin of file
			normal k$Jx
		endif
	else
		normal X		
	endif
endfunc
inoremap <silent> <BS> <C-O>:call <SID>JoinLinesBS()<CR>

func! s:JoinLinesDEL()
	if virtcol(".") != virtcol("$")
        normal x
	else
		normal gJ
	endif
endfunc
inoremap <silent> <DEL> <C-O>:call <SID>JoinLinesDEL()<CR>

