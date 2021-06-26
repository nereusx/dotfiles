#!/bin/sh

# session name
S="AN"
case "$(hostname)" in
quicksand64)	S="QS";;
srv-x230)		S="SV";;
void-t440s)		S="T4";;
esac

# create default layout (-d -s)
tmux new-session -A -d -s $S 
tmux new-window -n "root" 'sudo su -c "cd ; $SHELL"'
tmux new-window -n "root" 'sudo su -c "cd ; $SHELL"'
#tmux new-window -n "root" 'sudo su -c "cd ; $SHELL"'
tmux new-window -n "$USER"
tmux new-window -n "$USER"
tmux new-window -n "$USER"
tmux new-window -n "last"
tmux move-window -k -s 1 -t "last"
tmux move-window -r
tmux -2 attach-session -t $S

