#!/bin/bash

#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

FOREGROUND_COLOR=$foreground_color

#shows the time nothing fancy
clock() {
	TIME=$(date "+%I:%M:%S %p")
	echo -n "\uf017 ${TIME}"
}

#shows date, using show_date b/c im pretty sure calling it date doesn't work
show_date() {
	DATE=$(date "+%m/%d/%Y")
	echo "\uf073 ${DATE}"
}

#shows active window name
ActivateWindow(){
	len=$(echo -n "$(xdotool getwindowfocus getwindowname)" | wc -m)
	#max length of the line, so the length of it before the program says "fuck it" and just puts ...
	max_len=100
	if [ "$len" -gt "$max_len" ] ; then
		echo -n "$(xdotool getwindowfocus getwindowname | cut -c 1-$max_len)..."
	else
		echo -n "$(xdotool getwindowfocus getwindowname)"
	fi
}

VOLUME_TEXT=$volume_text

sound() {

	VOL=$(awk -F"[][]" '/%/ { print $2 }' <(amixer -D pulse sget Master) | sed 's/%//g' | head -n 1)
	echo "${VOLUME_TEXT}${VOL}"

}

#defines active and standard colors for the workspaces, defined in config file.
ACTIVE_COLOR=$workspace_active_color
STANDARD_COLOR=$foreground_color

workspaces() {
	#gets what the current desktop is and saves it in ACTUAL
	ACTUAL=$(xprop -root _NET_CURRENT_DESKTOP | awk '{printf $3}' ) 
	case $ACTUAL in
		0)
			#underlines, and changes color of current workspace
			echo -n "%{+u}%{F$ACTIVE_COLOR}1%{F$STANDARD_COLOR}%{-u} 2 3 4 5 6 7 8 9 0";;

		1)
			echo -n "1 %{+u}%{F$ACTIVE_COLOR}2%{F$STANDARD_COLOR}%{-u} 3 4 5 6 7 8 9 0";;

		2)
			echo -n "1 2 %{+u}%{F$ACTIVE_COLOR}3%{F$STANDARD_COLOR}%{-u} 4 5 6 7 8 9 0";;

		3)
			echo -n "1 2 3 %{F$ACTIVE_COLOR}%{+u}4%{-u}%{F$STANDARD_COLOR} 5 6 7 8 9 0";;

		4)
			echo -n "1 2 3 4 %{F$ACTIVE_COLOR}%{+u}5%{-u}%{F$STANDARD_COLOR} 6 7 8 9 0";;

		5)
			echo -n "1 2 3 4 5 %{F$ACTIVE_COLOR}%{+u}6%{-u}%{F$STANDARD_COLOR} 7 8 9 0";;

		6)
			echo -n "1 2 3 4 5 6 %{F$ACTIVE_COLOR}%{+u}7%{-u}%{F$STANDARD_COLOR} 8 9 0";;

		7)
			echo -n "1 2 3 4 5 6 7 %{F$ACTIVE_COLOR}%{+u}8%{-u}%{F$STANDARD_COLOR} 9 0";;	
		8)
			echo -n "1 2 3 4 5 6 7 8 %{F$ACTIVE_COLOR}%{+u}9%{-u}%{F$STANDARD_COLOR} 0";;
			
		9)
			echo -n "1 2 3 4 5 6 7 8 9 %{F$ACTIVE_COLOR}%{+u}0%{-u}%{F$STANDARD_COLOR}";;
		#this is the catch all just in case there are more workspaces I dont know about.
		*)
			echo -n "1 2 3 4 5 6 7 8 9 0%{F$ACTIVE_COLOR}%{+u}+%{-u}%{F$STANDARD_COLOR}";;
			
	esac
}

#THis only means that there is one monitor, if more, this breaks.
MONITOR_NAME=$(xrandr --listmonitors | awk '{print $4}')
BRIGHTNESS_TEXT=$brightness_text
curr_brightness=1
brightness() {
	brightness=$(xrandr --verbose | awk '/Brightness/ { print $2 }')
	#echo "%{A:xrandr --output eDP-1 --brightness .25:}LOW %{A} %{A:xrandr --output  --brightness .5:}MID %{A} %{A:xrandr --output DVI-D-0 --brightness 1:} FULL%{A}" 
	percentage=$(awk -v brightness="$brightness" 'BEGIN { printf "%.0f\n", brightness * 100 }')

	echo "${BRIGHTNESS_TEXT}${percentage}%"
}

BATTERY_TEXT=$battery_text

BATTERY_PERCENT_COLOR_HIGH=$battery_percent_color_high
BATTERY_PERCENT_COLOR_MED=$battery_percent_color_med
BATTERY_PERCENT_COLOR_LOW=$battery_percent_color_low


BATTERY_CHARGE_COLOR=$battery_charge_color


battery_percentage() {
	#Gets both the battery percentage, and Charge. I assume this is the same for all Linux things, but if not, this will be a problem. 
	BP=$(cat /sys/class/power_supply/BAT0/capacity)
	CHG=$(cat /sys/class/power_supply/BAT0/status)

	if [ "$CHG" = "Charging" ]; then
		echo "${BATTERY_TEXT}%{F$BATTERY_CHARGE_COLOR}CHRG(${BP}%)%{F$FOREGROUND_COLOR}"
	else
		if [ "$BP" -ge 70 ]; then
			echo "${BATTERY_TEXT}%{F$BATTERY_PERCENT_COLOR_HIGH}${BP}% %{F$FOREGROUND_COLOR}"
		elif [ "$BP" -ge 30 ]; then
			echo "${BATTERY_TEXT}%{F$BATTERY_PERCENT_COLOR_MED}${BP}% %{F$FOREGROUND_COLOR}"
		else
			echo "${BATTERY_TEXT}%{F$BATTERY_PERCENT_COLOR_LOW}${BP}% %{F$FOREGROUND_COLOR}"
			
		fi
	fi

}
#main loop, just echo all previous functs
SEPERATING_CHAR=$seperating_char
EDGE_CHAR=$edge_char
REFRESH_RATE=$refresh_rate

while true
do 
	echo -e "$EDGE_CHAR$(workspaces)$SEPERATING_CHAR$(ActivateWindow)%{r}$(brightness)$SEPERATING_CHAR$(sound)$SEPERATING_CHAR$(battery_percentage)$SEPERATING_CHAR$(show_date)$SEPERATING_CHAR$(clock)$EDGE_CHAR"
	sleep $REFRESH_RATE
done
