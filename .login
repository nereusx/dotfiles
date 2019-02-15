# .login, this executes only if it is login shell (-l option)
# after .[t]cshrc had executed

# cleanup path
if ( -e '/bin/path++' ) then
	setenv PATH `/bin/path++`
endif

# check whatever
#python-control isenabled
#if ( $status == 1 ) echo 'WARNING: Python had activated!'

# enable keypad
if ( $tty =~ tty* ) then
	/bin/echo -ne '\033='
endif

#
echo 'Welcome to tenex c-shell'
set list = ( neofetch screenfetch diogenis fortunes )
foreach f ( $list )
	if ( -X $f ) then
		$f
		break
	endif
end


