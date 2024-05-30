#!/bin/bash
#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

FOREGROUND_COLOR=$foreground_color

TIME_TEXT=$time_text
#shows the time nothing fancy
clock() {
	TIME=$(date "+%I:%M:%S %p")
	echo -n "${TIME_TEXT}${TIME}"
}

#shows date, using show_date b/c im pretty sure calling it date doesn't work
DATE_TEXT=$date_text
show_date() {
	DATE=$(date "+%m/%d/%Y")
	echo "${DATE_TEXT}${DATE}"
}

MAX_LEN=$max_len
#shows active window name
ActivateWindow(){
	len=$(echo -n "$(xdotool getwindowfocus getwindowname)" | wc -m)
	#max length of the line, so the length of it before the program says "fuck it" and just puts ...
	max_len=100
	if [ "$len" -gt "$MAX_LEN" ] ; then
		echo -n "$(xdotool getwindowfocus getwindowname | cut -c 1-$MAX_LEN)..."
	else
		echo -n "$(xdotool getwindowfocus getwindowname)"
	fi
}

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

#defines active and standard colors for the workspaces, defined in config file.
ACTIVE_COLOR=$workspace_active_color
STANDARD_COLOR=$foreground_color
BACK_COLOR=$workspace_back_color
#node for desktop, every single one checks if they are the current desktop, have something open
#in them, or neitehr. 
desktop() {
	if [ "$current_desktop" == "$1" ] ; then

		echo -n " %{A:wmctrl -s $(($1 - 1)):}%{+u}%{F$ACTIVE_COLOR}${current_desktop}%{F$STANDARD_COLOR}%{-u}%{A} "
	elif echo "$active_workspace_list" | grep -q "$1"; then
		echo -n %{A:wmctrl -s $(($1 - 1)):}" $1 "%{A}
	else
		echo %{A:wmctrl -s $(($1 - 1)):}""%{A}
	fi
}
workspaces() {
	#gets what the current desktop is and saves it in ACTUAL
	current_desktop=$(wmctrl -d | grep '\*' | awk '{print $1 + 1}')
	active_workspace_list=$(wmctrl -l | awk '{print $2 + 1}' | xargs)
	for value in 1 2 3 4 5 6 7 8 9 0; do
		results+=("$(desktop "$value")")
	done
	echo "${results[@]}"
}

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

cpu_temp() {
	
	echo $(sensors|awk 'BEGIN{i=0;t=0;b=0}/id [0-9]/{b=$4};/Core/{++i;t+=$3}END{if(i>0){printf("%0.1f\n",t/i)}else{sub(/[^0-9.]/,"",b);print b}}') ${CPU_TEMP}

}

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
#main loop, just echo all previous functs
SEPERATING_CHAR=$seperating_char
EDGE_CHAR=$edge_char
REFRESH_RATE=$refresh_rate

while true
do 
	echo -e "$EDGE_CHAR$(workspaces)$SEPERATING_CHAR$(ActivateWindow)%{r}$(ram_usage)$SEPERATING_CHAR$(cpu_temp)$SEPERATING_CHAR$(brightness)$SEPERATING_CHAR$(sound)$SEPERATING_CHAR$(battery_percentage)$SEPERATING_CHAR$(show_date)$SEPERATING_CHAR$(clock)$EDGE_CHAR"
	sleep $REFRESH_RATE
done
