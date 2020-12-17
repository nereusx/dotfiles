" File: csession.vim
" Author: Nicholas Christopoulos
" Version: 1.0
" Last Modified: 16 Dec 2020
"
" Overview
" --------
" Simple session manager. Save buffer-list at exit, load them at start.
"

" Has this already been loaded?
if exists('g:loaded_csession')
	finish
endif
let g:loaded_csession = v:true
let g:csession_directory = "~/.vim/sessions"
let g:csession_file = ""
let s:cstdin = 0

" mksession options
"set sessionoptions-=blank,options,folds
set sessionoptions-=blank,folds

" create directory if it is necessary
let s = expand(g:csession_directory)
if !isdirectory(s)
	if mkdir(s, "p", 0700) == 0
		throw printf('error: csession could create directory %s.', s)
	endif
endif

" save session
func! s:CSsave()
	if s:cstdin == 0
		let g:csession_file = substitute(getcwd(), '[/ ]', '_', 'g')
		silent! execute printf('mksession! %s/%s', expand(g:csession_directory), g:csession_file)
		echom printf('csession %s saved.', g:csession_file)
	endif
endfunc

" load session
func! s:CSload()
	let g:csession_file = substitute(getcwd(), '[/ ]', '_', 'g')
	let csdir = expand(g:csession_directory)

	if isdirectory(csdir)
		let	sfile = printf('%s/%s', csdir, g:csession_file)
		if filereadable(sfile)
			silent! execute printf('source %s', sfile)
			redraw
			echom printf('csession %s loaded.', sfile)
		endif
	endif
endfunc

" handle on-start event
func! s:OnStart()
	if ( argc() == 0 && s:cstdin == 0 ) " starting with no arguments, restore previous state
		call s:CSload()
    endif
endfunc

" handle on-exit event
func! s:OnExit()
	call s:CSsave()
endfunc

" set events
augroup CSession
	au! VimEnter * call <SID>OnStart()
	au! VimLeave * call <SID>OnExit()
	au! StdinReadPost * let s:cstdin = 1
augroup END

