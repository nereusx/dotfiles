#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

online_option_string="@online_icon"
offline_option_string="@offline_icon"
ping_timeout_string="@ping_timeout"
route_to_ping_string="@route_to_ping"

online_icon="✔"
offline_icon="❌ "
ping_timeout_default="1"
route_to_ping_default="1.1.1.1"

source $CURRENT_DIR/shared.sh

online_icon_default() {
	if [[ $TERM =~ tmux* ]]; then
		echo "1"
	else
		echo "$online_icon"
	fi
}

offline_icon_default() {
	if [[ $TERM =~ tmux* ]]; then
		echo "0"
	else
		echo "$offline_icon"
	fi
}

online_status() {
	if [ -x /usr/local/bin/isonline ]; then
		/usr/local/bin/isonline -q
	else
		ping -c 1 -t 1 1.1.1.1 >/dev/null 2>&1
	fi
}

if $(online_status); then
	printf "$(get_tmux_option "$online_option_string" "$(online_icon_default)")"
else
	printf "$(get_tmux_option "$offline_option_string" "$(offline_icon_default)")"
fi
