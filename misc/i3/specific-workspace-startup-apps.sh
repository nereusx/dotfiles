#!/bin/bash

i3-msg workspace 1
urxvt &
#google-chrome-stable --password-store=gnome &
#~/.config/i3/wait_for_app.sh "Google Chrome"

i3-msg workspace 2
urxvt &
#~/.config/i3/wait_for_app.sh "~"

i3-msg workspace 3
i3-msg layout tabbed
firefox &
~/.config/i3/wait_for_app.sh "Firefox"

i3-msg workspace 4
i3-msg layout tabbed
thunderbird &
~/.config/i3/wait_for_app.sh "Mozilla Thunderbird"
~/.bin/viber &
~/.config/i3/wait_for_app.sh "Viber"
#riot-desktop &
#~/.config/i3/wait_for_app.sh "Riot"
#rocketchat-desktop &
#~/.config/i3/wait_for_app.sh "Rocket.Chat"
