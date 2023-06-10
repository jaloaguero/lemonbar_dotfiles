#!/bin/bash

#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh

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

sound() {

	NOTMUTED=$( amixer sget Master | grep "\[on\]" )
	if [[ ! -z $NOTMUTED ]] ; then
		#gets the current volume 
		VOL=$(awk -F"[][]" '/%/ { print $2 }' <(amixer -D pulse sget Master) | sed 's/%//g' | head -n 1)
		#checks what the volume is
		if [ $VOL -ge 75 ] ; then
			#calls lemonbar_notifications to take care of sound change if pressed on 
			#wrapped both number and emoji so you can fat finger it as opposed to having to be accurate
			echo "%{A:sh .config/lemonbar/lemonbar_notifications.sh:}\uf028 ${VOL}%{A}"
		elif [ $VOL -ge 50 ] ; then
			echo "%{A:sh .config/lemonbar/lemonbar_notifications.sh:}\uf027 ${VOL}%{A}"
		else
			echo "%{A:sh .config/lemonbar/lemonbar_notifications.sh:}\uf026 ${VOL}%{A}"
		fi
	else
		echo "M"
	fi

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
		#this is the catch all just in case there are more workspaces I dont know about
		*)
			echo -n "1 2 3 4 5 6 7 8 9 0%{F$ACTIVE_COLOR}%{+u}+%{-u}%{F$STANDARD_COLOR}";;
			
	esac
}

#hacky and bad way to do it just a placeholder until i get something better
brightness() {

	echo "%{A:xrandr --output eDP-1 --brightness .25:}LOW %{A} %{A:xrandr --output  --brightness .5:}MID %{A} %{A:xrandr --output DVI-D-0 --brightness 1:} FULL%{A}" 
}

battery_percentage() {
	#Gets both the battery percentage, and Charge. I assume this is the same for all Linux things, but if not, this will be a problem. 
	BP=$(cat /sys/class/power_supply/BAT0/capacity)
	CHG=$(cat /sys/class/power_supply/BAT0/status)
	
	BATTERY_TEXT=$battery_text
	BATTERY_PERCENT_COLOR=$battery_percent_color
	BATTERY_CHARGE_COLOR=$battery_charge_color
			#echo -n "1 2 3 4 5 6 7 8 9 %{F#$ACTIVE_COLOR}%{+u}0%{-u}%{F#$STANDARD_COLOR}";;

	if [ "$CHG" = "Charging" ]; then
		echo "${BATTERY_TEXT}%{F$BATTERY_CHARGE_COLOR}CHRG(${BP}%)%{F$foreground_color}"
	else
		echo "${BATTERY_TEXT}${BP}%"
	fi

}
#main loop, just echo all previous functs
SEPERATING_CHAR_COLOR=$seperating_char_color
SEPERATING_CHAR={F$SEPERATING_CHAR_COLOR}$seperating_char{F$FOREGROUND_COLOR}

while true
do 
	echo -e "   $(workspaces)$seperating_char$(ActivateWindow)%{r}$(sound)$seperating_char$(battery_percentage)$seperating_char$(show_date)$seperating_char$(clock)   "
	sleep 0.05s
done
