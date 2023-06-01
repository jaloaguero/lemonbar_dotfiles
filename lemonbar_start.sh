#! /bin/sh
source ./lemonbar_config.sh
#This script killas all instances of lemonbar and its own script itself and runs lemonbar

killall -q lemonbar
killall -q bar_feeder

bash $lemonbar_path | lemonbar -g $lemonbar_path -p -F $foreground_color -B $background_color -f Terminus-10 -f FontAwesome-10 | $SHELL
