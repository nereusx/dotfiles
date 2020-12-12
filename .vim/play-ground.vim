"

function! FzyExecute(shell_command, vim_command)
	let output = ''
	silent let output = system(a:shell_command)
	redraw!
	if v:shell_error == 0 && !empty(output)
		exec a:vim_command . ' ' . output
	endif
endfunction

function! FzyBuffer()
	let tmp = tempname()
	exec 'redir > '.tmp | silent ls | redir END
	let $V_BUFFER_FILE = tmp
	let shell_cmd = 'cat $V_BUFFER_FILE |' .
        \ 'tail -n +2 |' .
        \ 'sed -r ''s/.*"(.+)".*/\1/'' |' .
        \ 'fzy'
	:call FzyExecute(shell_cmd, 'buffer')
endfunction

command! FzyBufList :call FzyBuffer()