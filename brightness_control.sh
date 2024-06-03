#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh


#THis only means that there is one monitor, if more, this breaks.
MONITOR_NAME=$(xrandr --listmonitors | awk '{print $4}')

BRIGHTNESS_TEXT_HIGH=$brightness_text_high
BRIGHTNESS_TEXT_MED=$brightness_text_med
BRIGHTNESS_TEXT_LOW=$brightness_text_low
BRIGHTNESS_TEXT_NONE=$brightness_text_none

curr_brightness=1
brightness() {
	brightness=$(xrandr --verbose | awk '/Brightness/ { print $2 }')
	#echo "%{A:xrandr --output eDP-1 --brightness .25:}LOW %{A} %{A:xrandr --output  --brightness .5:}MID %{A} %{A:xrandr --output DVI-D-0 --brightness 1:} FULL%{A}" 
	percentage=$(awk -v brightness="$brightness" 'BEGIN { printf "%.0f\n", brightness * 100 }')

	if [ "$percentage" -ge 75 ]; then
		echo "${BRIGHTNESS_TEXT_HIGH}${percentage}%"
	elif [ "$percentage" -ge 50 ]; then
		echo "${BRIGHTNESS_TEXT_MED}${percentage}%"
	elif [ "$percentage" -ge 25 ]; then
		echo "${BRIGHTNESS_TEXT_LOW}${percentage}%"
	else
		echo "${BRIGHTNESS_TEXT_NONE}${percentage}%"
	fi
}

call_brightness_controls() {

while true
do
	echo "brightness_controls$(brightness)"
	sleep $refresh_rate_short
done
}
