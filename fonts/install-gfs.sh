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
	GFS_NeoHellenic\
	GFS_Elpis\
	GFS_Didot_Classic\
	GFS_Porson\
	GFS_Philostratos\
	GFS_Baskerville"

#
echo "Εγκατάσταση γραμματοσειρών από την: "
echo "\033[1mΕταιρεία Ελληνικών Τυπογραφικών Στοιχείων\033[0m"
echo "GFS (Greek Fonts Society)"
echo "https://greekfontsociety-gfs.gr/"
echo
for f in $fonts; do
	[ -e ${f}.zip ] && rm ${f}.zip
	echo -n "$f: downloading"
	wget -q ${prefix}/${f}.zip
	echo -n " uncompressing"
	unzip ${f}.zip > /dev/null
	echo -n " installing"
	[ -d ${sysdir}/${f} ]			&& rm -r ${sysdir}/${f}
	[ "$f" = "GFS_Elpis" ]			&& mv -f GFS_ELPIS_OT ${f}
	[ "$f" = "GFS_Didot_Classic" ]	&& mv -f GFS_DIDOTCLASS_OT ${f}
	[ "$f" = "GFS_Porson" ]			&& mv -f GFS_PORSON ${f}
	[ "$f" = "GFS_Philostratos" ]	&& mv -f GFS_PHILOSTRATOS ${f}
	[ "$f" = "GFS_Baskerville" ]	&& mv -f GFS_BASKERVILLE ${f}
	mv -f ${f} ${sysdir}
	echo -n " cleanup"	
	[ -d __MACOSX ] && rm -r __MACOSX
	rm ${f}.zip
	echo " done"
done
echo "updating font-cache"
fc-cache
echo "done"
