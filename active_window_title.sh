#!/bin/bash
#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh



MAX_LEN=$max_len
#shows active window name
active_window_title(){
	len=$(echo -n "$(xdotool getwindowfocus getwindowname)" | wc -m)
	#max length of the line, so the length of it before the program says "fuck it" and just puts ...
	max_len=100
	if [ "$len" -gt "$MAX_LEN" ] ; then
		echo -n "$(xdotool getwindowfocus getwindowname | cut -c 1-$MAX_LEN)..."
	else
		echo -n "$(xdotool getwindowfocus getwindowname)"
	fi
}
call_active_window_title() {
while true
do
	echo "active_window_title $(active_window_title)"
	sleep $active_window_refresh_rate

done
}
