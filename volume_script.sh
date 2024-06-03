#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

VOLUME_TEXT_HIGH=$volume_text_high
VOLUME_TEXT_MED=$volume_text_med
VOLUME_TEXT_LOW=$volume_text_low
VOLUME_TEXT_NONE=$volume_text_none

sound() {

	VOL=$(awk -F"[][]" '/%/ { print $2 }' <(amixer -D pulse sget Master) | sed 's/%//g' | head -n 1)
	if [ "$VOL" -ge 70 ]; then
		echo "${VOLUME_TEXT_HIGH}${VOL}"
	elif [ "$VOL" -ge 30 ]; then
		echo -n "${VOLUME_TEXT_MED}${VOL}"
	elif [ "$VOL" -ge 1 ]; then
		echo "${VOLUME_TEXT_LOW}${VOL}"
	else
		echo "${VOLUME_TEXT_NONE}${VOL}"
	fi
}
call_volume_script() {

while true
do
	echo "volume_script$(sound)"
	sleep $refresh_rate_short
done
}
