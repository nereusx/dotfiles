#!/usr/bin/awk -f

BEGIN {
	for ( i = 33; i < 127; i ++ ) {
		printf "%03d %03o %02x -> \033[7m %c \033[27m", i, i, i, i;
		if ( (i % 4) == 0 ) printf "\n"; else printf "\t";
		}
	printf "\n";
	}
