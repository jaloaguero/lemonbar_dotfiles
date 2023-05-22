#!/bin/bash

ACTIVE_COLOR=DFB5FF
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

#defines active and standard colors for the workspaces
ACTIVE_COLOR=cfbe60
STANDARD_COLOR=FFFFFF

workspaces() {
	#gets what the current desktop is and saves it in ACTUAL
	ACTUAL=$(xprop -root _NET_CURRENT_DESKTOP | awk '{printf $3}' ) 
	case $ACTUAL in
		0)
			#underlines, and changes color of current workspace
			echo -n "%{+u}%{F#$ACTIVE_COLOR}1%{F#$STANDARD_COLOR}%{-u} 2 3 4 5 6 7 8 9 0";;

		1)
			echo -n "1 %{+u}%{F#$ACTIVE_COLOR}2%{F#$STANDARD_COLOR}%{-u} 3 4 5 6 7 8 9 0";;

		2)
			echo -n "1 2 %{+u}%{F#$ACTIVE_COLOR}3%{F#$STANDARD_COLOR}%{-u} 4 5 6 7 8 9 0";;

		3)
			echo -n "1 2 3 %{F#$ACTIVE_COLOR}%{+u}4%{-u}%{F#$STANDARD_COLOR} 5 6 7 8 9 0";;

		4)
			echo -n "1 2 3 4 %{F#$ACTIVE_COLOR}%{+u}5%{-u}%{F#$STANDARD_COLOR} 6 7 8 9 0";;

		5)
			echo -n "1 2 3 4 5 %{F#$ACTIVE_COLOR}%{+u}6%{-u}%{F#$STANDARD_COLOR} 7 8 9 0";;

		6)
			echo -n "1 2 3 4 5 6 %{F#$ACTIVE_COLOR}%{+u}7%{-u}%{F#$STANDARD_COLOR} 8 9 0";;

		7)
			echo -n "1 2 3 4 5 6 7 %{F#$ACTIVE_COLOR}%{+u}8%{-u}%{F#$STANDARD_COLOR} 9 0";;

		
		8)
			echo -n "1 2 3 4 5 6 7 8 %{F#$ACTIVE_COLOR}%{+u}9%{-u}%{F#$STANDARD_COLOR} 0";;
			
		9)
			echo -n "1 2 3 4 5 6 7 8 9 %{F#$ACTIVE_COLOR}%{+u}0%{-u}%{F#$STANDARD_COLOR}";;
		#this is the catch all just in case there are more workspaces I dont know about
		*)
			echo -n "1 2 3 4 5 6 7 8 9 0%{F#$ACTIVE_COLOR}%{+u}+%{-u}%{F#$STANDARD_COLOR}";;
			
	esac
}

#hacky and bad way to do it just a placeholder until i get something better
brightness() {

	echo "%{A:xrandr --output DVI-D-0 --brightness .25:}LOW %{A} %{A:xrandr --output DVI-D-0 --brightness .5:}MID %{A} %{A:xrandr --output DVI-D-0 --brightness 1:} FULL%{A}" 
}

#main loop, just echo all previous functs
while true
do 
	echo -e "   $(workspaces)   |   $(ActivateWindow)%{r}$(sound)   |   $(show_date)   |   $(clock)   "
	sleep 0.05s
done
