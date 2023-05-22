#! /bin/sh

#This script killas all instances of lemonbar and its own script itself and runs lemonbar

killall -q lemonbar
killall -q bar_feeder

bash ~/.config/lemonbar/bar_feeder.sh | lemonbar -g 1900x20+10+5 -p -F "#DFB5FF" -B "#140030" -f Terminus-10 -f FontAwesome-10 | $SHELL
