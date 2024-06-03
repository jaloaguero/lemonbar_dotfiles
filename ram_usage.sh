#!/bin/bash
#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

RAM_TEXT=$ram_text

RAM_COLOR_LOW=$ram_color_low
RAM_COLOR_MED=$ram_color_med
RAM_COLOR_HIGH=$ram_color_high

#Gets ram size, not in primary loop b/c this number should not change.
RAM_AVAIL=$(printf "%.1f" $(free -m | grep Mem | awk '{print ($2*0.001)}'))


ram_usage() {
	RAM_USAGE=$(printf "%.1f" $(free -m | grep Mem | awk '{print ($3*0.001)}'))
	
	RAM_PERCENT=$(free -m | grep Mem | awk '{print ($3/$2)*100}' | cut -d. -f1)

	if [ "$RAM_PERCENT" -ge 75 ]; then
		echo -n "${RAM_TEXT}${RAM_USAGE}GiB/${RAM_AVAIL}GiB%{F$RAM_COLOR_HIGH}(${RAM_PERCENT}%)%{F$FOREGROUND_COLOR}"
	elif [ "$RAM_PERCENT" -ge 40 ]; then
		echo -n "${RAM_TEXT}${RAM_USAGE}GiB/${RAM_AVAIL}GiB%{F$RAM_COLOR_MED}(${RAM_PERCENT}%)%{F$FOREGROUND_COLOR}"
	else
		echo -n "${RAM_TEXT}${RAM_USAGE}GiB/${RAM_AVAIL}GiB%{F$RAM_COLOR_LOW}(${RAM_PERCENT}%)%{F$FOREGROUND_COLOR}"
	fi
}

call_ram_usage() {
while true
do
	echo "ram_usage$(ram_usage)"
	sleep $refresh_rate_long
done
}
