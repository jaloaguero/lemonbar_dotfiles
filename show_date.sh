#!/bin/bash
#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

#shows date, using show_date b/c im pretty sure calling it date doesn't work
DATE_TEXT=$date_text
show_date() {
	DATE=$(date "+%m/%d/%Y")
	echo "${DATE_TEXT}${DATE}"
}
call_show_date() {

while true
do
	echo "show_date$(show_date)"
	sleep $date_refresh_rate
done
}
