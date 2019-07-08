#!/bin/tcsh
#
#	copy it to ~/.config/autostart-scripts
#

logger -t PAUSER "Check PulseAudio of $USER ($uid)"
while ( 1 )
	if ( { pgrep -u $uid pulseaudio } ) then
		logger -t PAUSER "Found!"
		systemctl --user stop pulseaudio.socket
		sleep 2
		systemctl --user stop pulseaudio.service
		sleep 8
		logger -t PAUSER "removed?"
	else
		logger -t PAUSER "The monster is dead"
		break
	endif
end
pactl set-default-sink 0
