#!/bin/sh

void -i net-tools inetutils iputils
xbps-alternatives -s net-tools
xbps-alternatives -s iputils
#xbps-alternatives -s gwhois
#xbps-alternatives -s inetutils-hostname
#xbps-alternatives -s inetutils-ifconfig
#xbps-alternatives -s inetutils-syslog
#xbps-alternatives -s inetutils-ping
#xbps-alternatives -s inetutils-traceroute
xbps-alternatives -s ksh


