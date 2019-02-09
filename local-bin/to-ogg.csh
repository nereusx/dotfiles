#!/bin/tcsh -f

set IFS='\t\n'
foreach f ( *.{wma,flac,mp3,wav} )
	ffmpeg -i "$f" "$f:r".ogg
end
