#!/bin/tcsh -f

set ins='xbps-install -y'

### generic
$ins linux-firmware
lspci | grep -i 'VGA compatible controller: NVIDIA' && set nvidia
lspci | grep -i 'VGA compatible controller: Intel'  && set intel

### drivers
if ( $?nvidia ) then
	$ins nvidia
	$ins nvidia-dkms
	$ins nvidia-gtklibs
	$ins nvidia-libs
	$ins nvidia-libs-32bit
else if ( $?intel ) then
	$ins mesa-intel-dri
	$ins libva-intel-driver
endif

### wine
$ins wine-mono
$ins wine-32bit
$ins wine-gecko
$ins winetricks
