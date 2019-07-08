#!/bin/tcsh

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
	sleep 2
end
pactl set-default-sink 0
logger -t PAUSER "Change the default sound card"
