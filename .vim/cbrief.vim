" File: cbrief.vim
" Description: fix and improvement of brief.vim
" Author: Nicholas Christopoulos (nereus@freemail.gr)
" Version: 1.0
" Last Modified: Jan 2021
"

" prevent to load again
if exists('g:loaded_ndc_brief')
    finish
endif
let g:loaded_ndc_brief = v:true

set virtualedit=onemore
set startofline
set backspace=indent,eol,start

if has("gui_running") == 0 && has("nvim") == 0
	if $TERM != "linux" " terminal emulator
		set esckeys
		"set modifyotherKeys
		let &t_TI = "\<Esc>[>4;2m"
		let &t_TE = "\<Esc>[>4;m"
	endif
endif

" Only insert mode is supported
" Use CTRL-O to execute one Normal mode command.
set insertmode

" msgbox:
" call popup_create('do you want to quit (Yes/no)?', #{
"	\ filter: 'popup_filter_yesno',
"	\ callback: 'QuitCallback',
"	\ })
"
" listbox:
" func ColorSelected(id, result) " use a:result, index or -1 for cancel
" endfunc
" call popup_menu(['red', 'green', 'blue'], #{
"	\ callback: 'ColorSelected',
"	\ })
"

" F10: command-line
inoremap <F10> <C-O>:
nnoremap <F10> <ESC>:

" F11: switch modes
func! cbrief#toggle_insert_mode()
	if &insertmode == 1
		set noinsertmode
	else
		set insertmode
	endif
endfunc

inoremap <F11> <C-O>:call cbrief#toggle_insert_mode()<CR>
nnoremap <F11> <ESC>:call cbrief#toggle_insert_mode()<CR><ESC>

" Alt+X: Quit
func! s:CountModBufs()
    redir => buflist
    silent! ls +
    redir END
    return len(split(buflist, '\n'))
endfunc

func! cbrief#quit()
	let cnt = s:CountModBufs()
	if cnt > 0
		let choice = confirm(
			\ printf('%d %s', cnt, 'buffer(s) has not been saved. Exit?'),
			\  "&yes\n&no\n&write", 1)
		if choice == 1
			silent! execute 'qa!'
		elseif choice == 2
			" nothing, remain in editor
			redraw
			echo "canceled"
		elseif choice == 3
			silent! execute 'wqa!'
			echom "write all and quit!"
		endif
	else
		silent! execute 'qa!'
	endif
endfunc
inoremap <A-x> <C-O>:call cbrief#quit()<CR>

" open file
inoremap <A-e> <C-O>:edit<space>

" search
inoremap <A-s> <C-O>/
inoremap <C-S> <C-O>?

" search next
inoremap <silent> <A-f> <C-O>n

" search next backward
inoremap <silent> <C-F> <C-O>N

" Search and replace from the current cursor position
inoremap <silent> <A-t> <F6>

" === clipboard ===
" Paste scrap buffer contents to current cursor position.
" Vim register 'a' is used as the scrap buffer
inoremap <silent> <Ins> <C-O>"aP
inoremap <silent> <C-V> <C-O>"aP
" Copy marked text to scrap.
inoremap <silent> <C-C> <C-O>"ayy
vnoremap <silent> <C-C> "ay
" Cut line or mark to scrap buffer.
inoremap <silent> <C-X> <C-O>"add
vnoremap <silent> <C-X> "ax

" shift-arrows
inoremap <S-Up>		<C-O>:normal V<CR>
inoremap <S-Down>	<C-O>:normal V<CR>
inoremap <S-Left>	<C-O>:normal v<CR>
inoremap <S-Right>	<C-O>:normal v<CR>
inoremap <S-Home>	<C-O>:normal v^<CR>
inoremap <S-End>	<C-O>:normal v$<CR>
vnoremap <S-Up>		k
vnoremap <S-Down>	j
vnoremap <S-Left>	h
vnoremap <S-Right>	l
" ================

" === system clipboard ===
func! cbrief#sys_paste()
	let ai = &autoindent
	let si = &smartindent
	let &autoindent = 0
	let &smartindent = 0
	exec 'normal "*P'
	let &smartindent = si
	let &autoindent = ai
	redraw
	echom "Clipborad's text inserted."
endfunc
command! Bxpaste	call cbrief#sys_paste()

" Copy marked text to system clipboard.  If no mark, copy current line
inoremap <silent> <C-Ins> <C-O>"*yy
vnoremap <silent> <C-Ins> "*y

" Paste the system clipboard contents to current cursor
inoremap <silent> <S-Ins> <C-O>:call cbrief#sys_paste()<CR>

" Cut the marked text to system clipboard. If no mark, cut the current line
inoremap <silent> <S-Del> <C-O>"*dd
vnoremap <silent> <S-Del> "*d
" ========================

" === windows ===

" move to window
inoremap <silent> <F1>	<C-O>:call <SID>ExecArrow(2)<CR>

" resize window
inoremap <silent> <F2>	<C-O>:call <SID>ExecArrow(3)<CR>

" Split window
inoremap <silent> <F3>	<C-O>:call <SID>ExecArrow(1)<CR>

" Close window
inoremap <silent> <F4>	<C-O>:call <SID>ExecArrow(4)<CR>

" ------------------

func! s:ExecArrow(mode)
let exitf = v:false
if a:mode == 1 " Split
	echo "Select side for the new window (use cursor keys)."
elseif a:mode == 2 " Move
	echo "Point to destination (use cursor keys)."
elseif a:mode == 3 " Resize
	echo "Select an edge to move (use cursor keys)."
elseif a:mode == 4 " Delete
	echo "Select window edge to delete (use cursor keys)."
endif
while !exitf
	let key = getchar()
	if a:mode == 1 " Split
		if key == "\<Left>"
			silent! exec "leftabove vsplit"
		elseif key == "\<Up>"
			silent! exec "leftabove split"
		elseif key == "\<Right>"
			silent! exec "rightbelow vsplit"
		elseif key == "\<Down>"
			silent! exec "rightbelow split"
		endif
		let exitf = v:true
	elseif a:mode == 2 " Move
		if key == "\<Left>"
			silent! exec "wincmd h"
		elseif key == "\<Up>"
			silent! exec "wincmd k"
		elseif key == "\<Right>"
			silent! exec "wincmd l"
		elseif key == "\<Down>"
			silent! exec "wincmd j"
		endif
		let exitf = v:true
	elseif a:mode == 3 " Resize
		if key == "\<Left>"
			silent! exec "vert res -1"
		elseif key == "\<Up>"
			silent! exec "res -1"
		elseif key == "\<Right>"
			silent! exec "vert res +1"
		elseif key == "\<Down>"
			silent! exec "res +1"
		elseif key == 27
			let exitf = v:true
		elseif key == 113
			let exitf = v:true
		else
			echo "key code = " .. string(key)
		endif
		let exitf = v:true " ??? getchar does not work well
	elseif a:mode == 4 " close
		if key == "\<Left>"
			silent! exec "wincmd h"
			silent! exec "close"
		elseif key == "\<Up>"
			silent! exec "wincmd k"
			silent! exec "close"
		elseif key == "\<Right>"
			silent! exec "wincmd l"
			silent! exec "close"
		elseif key == "\<Down>"
			silent! exec "wincmd j"
			silent! exec "close"
		endif
		let exitf = v:true
	endif
"	while getchar(1)
"		getchar(0)
"	endwhile
endwhile
endfunc

" buffer list
func! cbrief#buflist()
	call cbuflist#buflist()
"	exec "call quickui#tools#list_buffer('e')"
"	exec 'buffers' " if !quickui
endfunc
inoremap <silent> <A-b>	<C-O>:call cbrief#buflist()<CR>

function! s:FpMan(word)
	let opts = {"close":"button", "title":"Free Pascal Documentation: [" .. a:word .. "]"}
	let cmd = "fpman " .. a:word .. " | col -bx"
	call quickui#textbox#command(cmd, opts)
endfunc

function! s:UxMan(word)
	let opts = {"close":"button", "title":"Unix Man Pages: [" .. a:word .. "]"}
	let cmd = "man " .. a:word .. " | col -bx"
	call quickui#textbox#command(cmd, opts)
endfunc

function! s:HelpOnKey(word)
if &filetype == "pascal"
	call <SID>FpMan(a:word)
else
	call <SID>UxMan(a:word)
endif
endfunc

"inoremap <silent> <C-F1> <C-O>K
inoremap <silent> <C-F1> <C-O>:call <SID>HelpOnKey(expand("<cword>"))<CR>

let g:quickui_border_style = 2
command! Routines :call quickui#tools#list_function()
inoremap <silent> <C-G>	<C-O>:Routines<CR>

" Alt+H
func! cbrief#help()
	let topk = inputdialog('Enter topic: ', 'index', '')
	if topk != ''
		call quickui#tools#display_help(topk)
	endif
endfunc
inoremap <silent> <A-h>	<C-O>:call cbrief#help()<CR>

"command! NAV <C-L>:Explore<CR>

