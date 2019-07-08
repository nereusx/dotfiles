#!/bin/tcsh
#
#	This script kills the local user's pulseaudio
#

logger -t PAUSER "Check PulseAudio of $USER ($uid)"

logger -t PAUSER "Waiting ... the monster"
echo "Waiting..."
while ( 1 )
	if ( { pgrep -u $uid pulseaudio } ) then
		break
	endif
	sleep 4
	logger -t PAUSER "Waiting ..."
end

#
while ( 1 )
	if ( { pgrep -u $uid pulseaudio } ) then
		logger -t PAUSER "Found!"
		systemctl --user stop pulseaudio.socket
		sleep 4
		systemctl --user stop pulseaudio.service
		sleep 4
		logger -t PAUSER "removed?"
	else
		logger -t PAUSER "The monster is dead"
		break
	endif
	sleep 4
end
logger -t PAUSER "Change the default sound card"
pactl set-default-sink 0
sleep 1
notify-send "USER's PulseAudio is finally dead"
echo "* done *"
