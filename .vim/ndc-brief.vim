" cbrief.vim, fix and addons to brief.vim
" Nicholas Christopoulos (nereus@freemail.gr), 2012 .. 2021

" F10: command-line
inoremap <F10> <C-O>:

" Brief: Ctrl+W = toggle automatic backup
" Use VIM's Window Control
inoremap <C-W> <C-O><C-W>

" search
inoremap <silent> <A-s> <C-O>/
inoremap <silent> <C-S> <C-O>?

" search next
inoremap <silent> <A-f> <C-O>n

" search next backward
inoremap <silent> <C-F> <C-O>N

" Search and replace from the current cursor position
inoremap <silent> <A-t> <F6>

" Display buffer list
inoremap <A-b> <C-O>:buffers<CR>

" === clipboard ===
" Paste scrap buffer contents to current cursor position.
" Vim register 'a' is used as the scrap buffer
inoremap <silent> <C-V> <C-O>"ap
" Copy marked text to scrap.
inoremap <silent> <C-C> <C-O>"ayy
vnoremap <silent> <C-C> "ay
" Cut line or mark to scrap buffer.
inoremap <silent> <C-X> <C-O>"add
vnoremap <silent> <C-X> "ax
" ================

" === windows ===
" Split window
inoremap <silent> <F3> <C-O>:WinSplit<CR>

" move to window
inoremap <silent> <F1> <C-O><C-W>

" ------------------

func! NDCWinSplit()
	call inputsave()
	let dir = input("(v)ertical or (h)orizontal ? ")
	call inputrestore()
	if dir == "h"
		:split
	else
		:vsplit
	endif
endfunc
command! WinSplit :call NDCWinSplit()



