#!/bin/sh
#
#	Εταιρεία Ελληνικών Τυπογραφικών Στοιχείων (Greek Fonts Society)
#	https://greekfontsociety-gfs.gr/
#

set -e
. ./TTFDIR

#
prefix="https://greekfontsociety-gfs.gr/_assets/fonts"
fonts="GFS_Didot\
	GFS_Bodoni\
	GFS_Olga\
	GFS_Artemisia\
	GFS_NeoHellenic\
	GFS_Elpis\
	GFS_Galatea\
	GFS_Didot_Classic\
	GFS_Porson\
	GFS_Philostratos\
	GFS_Baskerville\
	GFS_Gazis\
	GFS_Nicefore\
	GFS_Eustace\
"

#
echo "Εγκατάσταση γραμματοσειρών από την"
echo
echo "\t\033[1;32mΕταιρεία Ελληνικών Τυπογραφικών Στοιχείων\033[0m"
echo "\tGFS (Greek Fonts Society)"
echo "\t\033[4;1;34mhttps://greekfontsociety-gfs.gr\033[0m"
echo
for f in $fonts; do
	[ -e ${f}.zip ] && rm ${f}.zip
	echo -n "$f:\033[25Gdownloading"
	wget -q ${prefix}/${f}.zip
	echo -n " uncompressing"
	unzip ${f}.zip > /dev/null
	echo -n " installing"

	# if the directory its in upper-case, fix it
	u=$(echo "$f" | awk '{print toupper($0)}')
	[ -d $u ] && mv -f $u $f
	
	# remove old directory
	[ -d ${sysdir}/${f} ]			&& rm -r ${sysdir}/${f}
	
	# copy it 
	[ "$f" = "GFS_Elpis" ]			&& mv -f GFS_ELPIS_OT ${f}
	[ "$f" = "GFS_Didot_Classic" ]	&& mv -f GFS_DIDOTCLASS_OT ${f}
	mv -f ${f} ${sysdir}

	echo -n " cleanup"	
	[ -d __MACOSX ] && rm -r __MACOSX
	rm ${f}.zip
	echo " done"
done
[ -e "._GFS_GAZIS" ] && rm "._GFS_GAZIS"
echo "updating font-cache"
fc-cache
echo "done"
