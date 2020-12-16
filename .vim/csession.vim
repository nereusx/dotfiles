" File: csession.vim
" Author: Nicholas Christopoulos
" Version: 1.0
" Last Modified: 16 Dec 2020
"
" Overview
" --------
" Simple session manager. Save buffer list at exit, load them at start.
"

" Has this already been loaded?
if exists('g:loaded_csession')
	finish
endif
let g:loaded_csession = v:true
let g:csession_directory = "~/.vim/sessions"
let s:dont_save = 0

" save session
func! s:CSsave()
	if s:dont_save == 0
		let sfile = substitute(getcwd(), '[/ ]', '_', 'g')
		let csdir = substitute(g:csession_directory, '\~', $HOME, 'g')

		if !isdirectory(csdir)
			silent! execute printf('!mkdir -p %s', csdir)
		endif
		silent! execute printf('mksession! %s/%s', csdir, sfile)
		echom 'csession saved.'
	endif
endfunc

" load session
func! s:CSload()
	let sfile = substitute(getcwd(), '[/ ]', '_', 'g')
	let csdir = substitute(g:csession_directory, '\~', $HOME, 'g')

	if isdirectory(csdir)
		let	sfile = printf('%s/%s', csdir, sfile)
		if filereadable(sfile)
			silent! execute printf('source %s', sfile)
			redraw
			echom 'csession loaded.'
		endif
	else
		throw printf('csession error, %s is not directory.', csdir)
	endif
endfunc

" handle on-start event
func! s:OnStart()
	if ( argc() == 0 ) " starting with no arguments, restore previous state
		call s:CSload()
    endif
endfunc

" handle on-exit event
func! s:OnExit()
	call s:CSsave()
endfunc

" setting events
augroup CSession
	au! VimEnter * call <SID>OnStart()
	au! VimLeave * call <SID>OnExit()
	au! StdinReadPost * let s:dont_save = 1
augroup END

