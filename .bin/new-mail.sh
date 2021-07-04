#!/bin/sh
sound="${HOME}/.sounds/new-mail.wav"
[ -f $sound ] && play -q $sound
#say-new-messages "$1"

