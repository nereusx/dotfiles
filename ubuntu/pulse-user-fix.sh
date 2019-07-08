#!/bin/tcsh

logger -t PAUSER "Check PulseAudio of $USER ($uid)"

logger -t PAUSER "Waiting ... the monster"
while ( 1 )
	if ( { pgrep -u $uid pulseaudio } ) then
		break
	endif
	sleep 5
	logger -t PAUSER "Waiting ..."
end

#
while ( 1 )
	if ( { pgrep -u $uid pulseaudio } ) then
		logger -t PAUSER "Found!"
		systemctl --user stop pulseaudio.socket
		sleep $delay
		systemctl --user stop pulseaudio.service
		sleep 5
		logger -t PAUSER "removed?"
	else
		logger -t PAUSER "The monster is dead"
		notify-send -t PAUSER "The monster is dead"
		break
	endif
	sleep 5
end
logger -t PAUSER "Change the default sound card"
pactl set-default-sink 0
echo "* done *"
