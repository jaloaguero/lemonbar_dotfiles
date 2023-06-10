#! /bin/bash

#Lemonbar starter. Everything is defined in the .config file. This exists to be able to run everything from a single file call. 

#This grabs the script location, then adds it to source, so we can call the config file from anywhere.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

#kills all other lemonbar instances
killall -q lemonbar
killall -q bar_feeder

#Actually runs lemonbar. 
bash $lemonbar_path | lemonbar -g $bar_dimensions -p -F $foreground_color -B $background_color -f Terminus-10 -f FontAwesome-10 | $SHELL
