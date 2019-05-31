#!/bin/sh
Athens='https://www.accuweather.com/el/gr/athens/182536/weather-forecast/182536'
Nafplio='https://www.accuweather.com/el/gr/nafplio/182196/weather-forecast/182196'
URL="$Athens"
#wget -q -O- "$URL" | awk -F\' '/acm_RecentLocationsCarousel\.push/{print $2": "$16", "$12"°" }'| head -1
#wget -q -O- "$URL"
curl "$URL"

