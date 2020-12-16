" cbrief.vim, fix and addons to brief.vim
" Nicholas Christopoulos (nereus@freemail.gr), 2012 .. 2021
"
" Required:
"	vim-quickui
"

" prevent to load again
if exists('g:loaded_ndc_brief')
    finish
endif
let g:loaded_ndc_brief = v:true

set virtualedit=onemore
set startofline
set backspace=indent,eol,start

" Only insert mode is supported
" Use CTRL-O to execute one Normal mode command.
set insertmode

" export msgbox
func! cbrief#msgbox(title, lines)
	let opts = {'close':'button'}
	let opts.index = 1
	let opts.resize = 1
	let opts.title = a:title
	call quickui#textbox#create(a:lines, opts)
endfunc

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
" ================

" === system clipboard ===
func! cbrief#sys_paste()
	let ai = &autoindent
	let si = &smartindent
	set noautoindent
	set nosmartindent
	normal "*P
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
	exec "call quickui#tools#list_buffer('e')"
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
inoremap <silent> <A-h>	<C-O>:call quickui#tools#display_help('index')<CR>

"command! NAV <C-L>:Explore<CR>

