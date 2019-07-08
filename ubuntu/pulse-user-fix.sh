#!/bin/tcsh -f
#
#	copy it to ~/.config/autostart-scripts
#

logger -t PAUSER "Check PulseAudio of $USER ($uid)"
while ( 1 )
	pgrep -u $uid pulseaudio
	if ( $? == 0 ) then
		logger -t PAUSER "Found!"
		/usr/local/bin/pulseaudio-stop.sh
		pactl set-default-sink 0
		logger -t PAUSER "removed?"
	else
		logger -t PAUSER "No found"
		break
	endif
end
