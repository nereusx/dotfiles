#!/bin/sh
Athens='https://www.okairos.gr/%CE%B1%CE%B8%CE%AE%CE%BD%CE%B1.html'
Nafplio='https://www.okairos.gr/%CE%BD%CE%B1%CF%8D%CF%80%CE%BB%CE%B9%CE%BF.html'
URL="$Athens"
wstart="Τρέχουσες συνθήκες"
wend="</div>"
#wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1
#wget -q -O- "$URL"
#curl "$URL" | xml2asc
w3m -dump "$URL"

