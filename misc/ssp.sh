#!/bin/ksh

# SCCS editing wrapper, version 1.3
#  Author - Phil Brown
#  Usage: see usage() function, below

usage(){
	print sedit - a wrapper to edit files under SCCS
	print "Usage: sedit [-c|-C] [-f] file {file2 ...}"
	print "  -c   check in file(s) after edit is complete"
	print "  -C   check in all files with single revision message"
	print "  -f   ignore errors in checkout"
}

# Set EDITOR var to "vi" if not already set to something
EDITOR=${EDITOR:-vi}
# Could already be in path, but it doesnt hurt to add it again.
# Sorry, I assume solaris machines everywhere: adjust as needed.
PATH=$PATH:/usr/ccs/bin
if [ ! -x /usr/ccs/bin/sccs ] ; then
	print ERROR: sccs not installed on this machine. Cannot continue.
	usage
	exit 1
fi


while getopts "cCfh" arg
do
	case $arg in
	    c)
	    	checkin="yes"
		;;
	    C)
	    	checkinall="yes"
		;;
	    f)
	    	force="yes"
		;;
	    h|*)
	    	usage
		exit 1
		;;
	esac
done

shift $(($OPTIND - 1))

if [ $# -lt 1 ] ; then
	usage
	print ERROR: no files specified
	exit 1
fi

if [ "$checkinall" != "" ] && [ "$checkin" != "" ] ; then
	print WARNING: -c and -C used. Will use -C.
fi

# Yes, I could use "sccs edit $@" and check for a single error, but this
# approach allows for finer error reporting.
#  "$@" is a special construct that catches spaces in filenames.
#   Note that "$*" is NOT 100% the same thing.
for f in "$@" ; do
	sccs edit "$f"
	if [ $? -ne 0 ] ; then
		print ERROR checking out file $f
		if [ "$force" = "" ] ; then
			if [ "$filelist" != "" ] ; then
				print "Have checked out $filelist"
			fi
			exit 1
		fi
		# else, -f is in effect. Keep going
	fi
	filelist="$filelist $f"
done

# I would like to use "$filelist", but that does not preserve spaces
# in file names
$EDITOR "$@"
status=$?
if [ $status -ne 0 ] ; then
	print ERROR: $EDITOR returned error status $status
	exit $status
	# For editors, it isnt really important to exit with the exact same
	# error status. However, for more complex programs, and particularly
	# since this is supposed to be a more or less transparent wrapper
	# around $EDITOR, it would be important to return the exact same
	# error status of the program we are wrapping
fi

if [ "$checkinall" != "" ] ; then
	# -C option used. re-check in all files at once.
	sccs delget "$@"
	if [ $? -ne 0 ] ; then
		print "ERROR checking in files?"
		exit 1
	fi
	exit 0
fi
if [ "$checkin" != "" ] ; then
	# -c option used. re-check in each file.
	for file in $filelist ; do
		sccs delget $file
		if [ $? -ne 0 ] ; then
			print "WARNING: failed to check in $file"
		fi
		# do NOT stop after error. Keep trying to check
		# in any other files
	done
fi

