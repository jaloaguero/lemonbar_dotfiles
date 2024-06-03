#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh


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
workspace() {
	#gets what the current desktop is and saves it in ACTUAL
	current_desktop=$(wmctrl -d | grep '\*' | awk '{print $1 + 1}')
	active_workspace_list=$(wmctrl -l | awk '{print $2 + 1}' | xargs)

	for value in 1 2 3 4 5 6 7 8 9 0; do
		results+=("$(desktop "$value")")
	done
	echo "${results[@]}"
}


call_workspace() {

	while true
	do
		echo "workspace $(workspace)"
		sleep $workspace_refresh_rate
	done
}
