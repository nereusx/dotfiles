# creates bash compatible arrays

function ltrim(s)	{ sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s)	{ sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s) 	{ return rtrim(ltrim(s)); }

function replace_variables(s) {
	for ( i = 0; i < v_count; i ++ )
		gsub("\\${"vname[i]"}", vvalue[i], s);
	return s
	}

# startup
BEGIN {
	sysdir="/etc/X11/xinit-rc"
	home=ENVIRON["HOME"]
	user=ENVIRON["USER"]
	v_count = 0
	e_count = 0
	}

# comment-line
/^#.*$/		{ next }

# empty line
/^[ \t]*$/	{ next }

# set variable
/^[ \t]*[0-9A-Za-z_]+[ \t]*=/	{
	split($0, a, "=")
	vname [v_count] = trim(a[1])
	vvalue[v_count] = trim(a[2])
	v_count ++
	next 
	}

# has variables
/\$\{[0-9A-Za-z_]+\}/ {
	$0 = replace_variables($0)
	}

# database line
/^*;/ {
	split($0, a, ";")
	e_key [e_count] = trim(a[1])
	e_desc[e_count] = trim(a[2])
	e_cmd [e_count] = trim(a[3])
	e_spre[e_count] = trim(a[4])
	e_npre[e_count] = trim(a[5])
	e_count ++
	}

#
END {
	print "# xde.database\n"
	print "xde_count="e_count"\n"
	e_max=e_count-1
	print "xde_max="e_max"\n"
	print "# table of keys"
	printf("xde_key=(")
	for ( i = 0; i < e_count; i ++ ) printf("\"%s\" ", e_key[i])
	printf(")\n\n")
	print "# table of descriptions"
	printf("xde_desc=(")
	for ( i = 0; i < e_count; i ++ ) printf("\"%s\" ", e_desc[i])
	printf(")\n\n")
	print "# table of commands"
	printf("xde_cmd=(")
	for ( i = 0; i < e_count; i ++ ) printf("\"%s\" ", e_cmd[i])
	printf(")\n\n")
	print "# table of session execution prefix"
	printf("xde_spre=(")
	for ( i = 0; i < e_count; i ++ ) printf("\"%s\" ", e_spre[i])
	printf(")\n\n")
	print "# table of normal execution prefix"
	printf("xde_npre=(")
	for ( i = 0; i < e_count; i ++ ) printf("\"%s\" ", e_npre[i])
	printf(")\n\n")
	}
