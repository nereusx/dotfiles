/*
 * check and add directories to a path
 * nicholas christopoulos (nereus@freemail.gr)
 *
 * PATH's penticure
 *
 * usage: setenv PATH `path++ [[new-dir] ...]`
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

char usage[] =
"check and add directories to a path\n"
"nicholas christopoulos (nereus@freemail.gr)\n"
"\n"
"usage: setenv PATH `path++ [[new-dir] ...]`\n"
"\n";

int main(int argc, char **argv)
{
	const char *spath = getenv("PATH");
	char	*buf, *dir, *p, *dst, *d, *res;
	int		i, len = strlen(spath) + 16;
	struct stat st;

	for ( i = 1; i < argc; i ++ )
		len += strlen(argv[i]) + 1;
	buf = (char *) malloc(len);
	dst = dir = (char *) malloc(len);
	res = (char *) malloc(len);

	buf[0] = ':'; buf[1] = '\0';
	strcpy(buf+1, spath);
	for ( i = 1; i < argc; i ++ ) {
		if ( argv[i][0] == '-' ) {
			/* options, or error */
			puts(usage);
			return 1;
			}
		else {
			strcat(buf, ":");
			strcat(buf, argv[i]);
			}
		}

	strcat(buf, ":"); /* final delimiter */

	p = buf + 1;
	d = dst;
	*d ++ = ':';
	*res = '\0';
	while ( *p ) {
		if ( *p == ':' ) {
			*d = '\0';
			d = dst;
			if ( strstr(p, dst) == 0 ) { /* not found; add it */
				if ( stat(dst+1, &st) == 0 )
					if ( S_ISDIR(st.st_mode) )
						strcat(res, dst);
				}
			}
		*d ++ = *p ++;
		}

	puts(res+1);
	res[0] = '\n'; res[1] = '\0';
	puts(res);
	fflush(stdout);

	free(dir);
	free(buf);
	free(res);
	return 0;
}
