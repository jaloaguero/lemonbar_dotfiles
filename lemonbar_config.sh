#!/bin/bash
#
#CONFIG FILE
#
#This is where we define where bar_feeder.sh is. This should work out of the box, but if you move files around, please define that here. 
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
lemonbar_path="$SCRIPT_DIR/bar_feeder.sh"


#Foreground and background colors:
#Foreground is the color of the text, background is the color of the bar itsself. 
foreground_color="#DFB5FF"
background_color="#5B368F"

#The char that seperates all things from each other. I suggest spaces.
seperating_char="   ~   "
edge_char="   "
refresh_rate=0.05s

#Workspaces colors
workspace_active_color="#CFBE60"

#Battery config:

battery_text="BATTERY: "

battery_percent_color_high="#358C5C"
battery_percent_color_med="#8C7935"
battery_percent_color_low="#8C3535"

battery_charge_color="#358C5C"

brightness_text="BRIGHTNESS: "

volume_text="VOL: "
#how big the bar is. This is optimized for 1080p

bar_length="1920"
bar_height="20"

bar_dimensions="1900x20+10+5"

#To add:
#Different xrandr output, as that is currently hardcoded. Ideally something along the lines of 
#having it grab your output name directly.
#Idk how different laptops do it, but my battery has "cat /sys/class/power_supply/BAT0/capacity"
#to show battery power, might want to also grep this so its more "universal"
