# select kshrc 88's or 93's

if [ -n "$KSH_VERSION" ]; then
	echo -n "$(pwd)/.kshrc: $0 "
	set +o sh
	case $KSH_VERSION in
	*MIRBSD\ KSH*)
				set +o posix
				rc="$HOME/.mkshrc" 
				;;
	*PD\ KSH*)
				set +o posix
				rc="$HOME/.ksh88rc"
				;;
	Version*\ 20[0-9][0-9]\.*)
				$__ksh_version="$($0 --version)"
				rc="$HOME/.ksh93rc"
				;;
	*)			rc="" ;;
	esac
	echo $rc
	[ -n "$__ksh_version" ] && echo $__ksh_version
	if [ -r $rc ]; then
		export ENV=$rc
		. $rc
		return 0
	elif [ -r $HOME/.kshrc ]; then
		export ENV="$HOME/.kshrc"
	fi
	echo "This version of KSH is not supported; please update the ~/.ashrc"
else
	echo "error: wrong shell"
fi
exit 1

