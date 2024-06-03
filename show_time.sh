#!/bin/bash
#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

TIME_TEXT=$time_text
#shows the time nothing fancy
show_time() {
	TIME=$(date "+%I:%M:%S %p")
	echo -n "${TIME_TEXT}${TIME}"
}


call_show_time() {

	while true
	do
		echo "show_time$(show_time)"
		sleep $refresh_rate_long
	done
}

