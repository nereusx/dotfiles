/*
 *	command [parameters]
 *
 *	Description
 * 
 *	Copyright (C) 2021 Nicholas Christopoulos.
 *
 *	This is free software: you can redistribute it and/or modify it under
 *	the terms of the GNU General Public License as published by the
 *	Free Software Foundation, either version 3 of the License, or (at your
 *	option) any later version.
 *
 *	It is distributed in the hope that it will be useful, but WITHOUT ANY
 *	WARRANTY; without even the implied warranty of MERCHANTABILITY or
 *	FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License
 *	for more details.
 *
 *	You should have received a copy of the GNU General Public License
 *	along with it. If not, see <http://www.gnu.org/licenses/>.
 *
 * 	Written by Nicholas Christopoulos <nereus@freemail.gr>
 */

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>

#define MAX(a,b)	((a>b)?(a):(b))
#define MIN(a,b)	((a<b)?(a):(b))

// --- definitions ----------------------------------------------------

// --- globals --------------------------------------------------------
int opt_flags = 0;

// --- library --------------------------------------------------------

// --- process --------------------------------------------------------

// --- main -----------------------------------------------------------

#define APP_NAME	"command"
#define APP_DESCR	"description."
#define APP_VER		"1.0"

static const char *usage = "\
Usage: "APP_NAME" [parameters]\n\
"APP_DESCR"\n\
\n\
Options:\n\
\t-\tread from stdin\n\
\t-h\tthis screen\n\
\t-v\tversion and program information\n\
";

static const char *verss = "\
"APP_NAME" version "APP_VER"\n\
"APP_DESCR"\n\
\n\
Copyright (C) 2017-2021 Free Software Foundation, Inc.\n\
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.\n\
This is free software: you are free to change and redistribute it.\n\
There is NO WARRANTY, to the extent permitted by law.\n\
\n\
Written by Nicholas Christopoulos <mailto:nereus@freemail.gr>\n\
";

// main()
int main(int argc, char **argv) {
	int		i, j;
	int		*int_ptr = NULL;
	char	*files[64];
	int		fcount = 0;

	// parsing arguments
	for ( i = 1; i < argc; i ++ ) {
		if ( int_ptr ) { // i am waiting an integer
			*int_ptr = (int) atoi(argv[i]);
			int_ptr = NULL;
			}
		else if ( argv[i][0] == '-' ) {

			if ( argv[i][1] == '\0' ) {	// one minus, read from stdin
				files[fcount ++] = strdup("-");
				continue; // we finished with this argv
				}

			// check options
			for ( j = 1; argv[i][j]; j ++ ) {
				switch ( argv[i][j] ) {
				case 'h': puts(usage); return 1;
				case 'v': puts(verss); return 1;
				case '-': // -- double minus, long option
					if ( strcmp(argv[i], "--help") == 0 )    { puts(usage); return 1; }
					if ( strcmp(argv[i], "--version") == 0 ) { puts(verss); return 1; }
					return 1;
				default:
					fprintf(stderr, "unknown option [%c]", argv[i][j]);
					return 1;
					}
				}
			}
		else
			files[fcount ++] = strdup(argv[i]);
		}

	// no arguments, read from stdin
	if ( fcount == 0 )
		files[fcount ++] = strdup("-"); // stdin

	//
	for ( i = 0; i < fcount; i ++ ) {
		if ( files[i][0] == '-' )
			process(stdin);
		else if ( access(files[i], R_OK) == 0 ) {
			FILE *fp = fopen(files[i], "rb");
			if ( fp ) {
				process(fp);
				fclose(fp);
				}
			else
				fprintf(stderr, "cannot open %s\n", files[i]);
			}
		else
			fprintf(stderr, "cannot open %s\n", files[i]);
		}

	// clean up & exit
	for ( i = 0; i < fcount; i ++ )
		free(files[i]);
	return EXIT_SUCCESS;
	}

