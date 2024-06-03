#!/bin/bash

#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh


source $SCRIPT_DIR/active_window_title.sh
source $SCRIPT_DIR/battery_percentage.sh
source $SCRIPT_DIR/brightness_control.sh
source $SCRIPT_DIR/cpu_temp.sh
source $SCRIPT_DIR/ram_usage.sh
source $SCRIPT_DIR/show_date.sh
source $SCRIPT_DIR/show_time.sh
source $SCRIPT_DIR/volume_script.sh
source $SCRIPT_DIR/workspace.sh


FOREGROUND_COLOR=$foreground_color


MAX_LEN=$max_len
#main loop, just echo all previous functs
SEPERATING_CHAR=$seperating_char
EDGE_CHAR=$edge_char




BAR_FIFO=/tmp/bar_fifo
rm $BAR_FIFO
mkfifo $BAR_FIFO

call_active_window_title > "$BAR_FIFO" &
call_battery_percentage >  "$BAR_FIFO" &
call_brightness_controls >  "$BAR_FIFO" &
call_cpu_temp >  "$BAR_FIFO" &
call_ram_usage >  "$BAR_FIFO" &
call_show_date  >  "$BAR_FIFO" &
call_show_time >  "$BAR_FIFO" &
call_volume_script  >  "$BAR_FIFO" &
call_workspace >  "$BAR_FIFO" &

while true
do
    read -r line < $BAR_FIFO
    case $line in
        active_window_title*)
            prefix="active_window_title"
            active_window_title=${line:${#prefix}}
            ;;
        battery_percentage*)
            prefix="battery_percentage"
            battery_percentage=${line:${#prefix}}
            ;;
        brightness_controls*)
            prefix="brightness_controls"
            brightness_controls=${line:${#prefix}}
            ;;
        cpu_temp*)
            prefix="cpu_temp"
            cpu_temp=${line:${#prefix}}
            ;;
        ram_usage*)
            prefix="ram_usage"
            ram_usage=${line:${#prefix}}
            ;;
        show_date*)
            prefix="show_date"
            show_date=${line:${#prefix}}
            ;;
        show_time*)
            prefix="show_time"
            show_time=${line:${#prefix}} 
            ;;
        volume_script*)
            prefix="volume_script"
            volume_script=${line:${#prefix}}
            ;;
        workspace*)
            prefix="workspace"
            workspace=${line:${#prefix}}
            ;;
    esac
	  echo -e "$EDGE_CHAR${workspace}$SEPERATING_CHAR${active_window_title}%{r}${ram_usage}$SEPERATING_CHAR${cpu_temp}$SEPERATING_CHAR${brightness_controls}$SEPERATING_CHAR${volume_script}$SEPERATING_CHAR${battery_percentage}$SEPERATING_CHAR${show_date}$SEPERATING_CHAR${show_time}$EDGE_CHAR"
done


