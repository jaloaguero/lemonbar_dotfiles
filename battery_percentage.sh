#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh


BATTERY_TEXT_HIGH=$battery_text_high
BATTERY_TEXT_MED=$battery_text_med
BATTERY_TEXT_LOW=$battery_text_low

BATTERY_PERCENT_COLOR_HIGH=$battery_percent_color_high
BATTERY_PERCENT_COLOR_MED=$battery_percent_color_med
BATTERY_PERCENT_COLOR_LOW=$battery_percent_color_low

BATTERY_TEXT_CHARGE=$battery_text_charge
BATTERY_CHARGE_COLOR=$battery_charge_color


battery_percentage() {
	#Gets both the battery percentage, and Charge. I assume this is the same for all Linux things, but if not, this will be a problem. 
	BP=$(cat /sys/class/power_supply/BAT0/capacity)
	CHG=$(cat /sys/class/power_supply/BAT0/status)

	if [ "$CHG" = "Charging" ]; then
		echo "${BATTERY_TEXT_CHARGE}%{F$BATTERY_CHARGE_COLOR}CHRG(${BP}%)%{F$FOREGROUND_COLOR}"
	else
		if [ "$BP" -ge 70 ]; then
			echo "${BATTERY_TEXT_HIGH}%{F$BATTERY_PERCENT_COLOR_HIGH}${BP}% %{F$FOREGROUND_COLOR}"
		elif [ "$BP" -ge 30 ]; then
			echo "${BATTERY_TEXT_MED}%{F$BATTERY_PERCENT_COLOR_MED}${BP}% %{F$FOREGROUND_COLOR}"
		else
			echo "${BATTERY_TEXT_LOW}%{F$BATTERY_PERCENT_COLOR_LOW}${BP}% %{F$FOREGROUND_COLOR}"
			
		fi
	fi

}
call_battery_percentage() {
while true
do
	echo "battery_percentage$(battery_percentage)"
	sleep $battery_refresh_rate
done
}
