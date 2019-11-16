#!/bin/sh
tmux new-window -n "root" 'sudo su'
tmux new-window -n "root" 'sudo su'
tmux new-window -n "root" 'sudo su'
tmux new-window -n "$USER"
tmux new-window -n "$USER"
tmux new-window -n "last"
tmux move-window -k -s 1 -t "last"
tmux move-window -r


