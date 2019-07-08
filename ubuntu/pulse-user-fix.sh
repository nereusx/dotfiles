#!/bin/tcsh -f
#
#	copy it to ~/.config/autostart-scripts
#

logger -t PAUSER "Check PulseAudio of $USER ($uid)"
pgrep -u $uid pulseaudio
if ( $? == 0 ) then
	logger -t PAUSER "Found!"
	( sleep 10; \
		/usr/local/bin/pulseaudio-stop.sh; \
		sleep 5; \
		pactl set-default-sink 0; \
		notify-send "PulseAudio Patch Applied" ) &
	logger -t PAUSER "It will removed in 15s"
else
	logger -t PAUSER "No found"
endif
