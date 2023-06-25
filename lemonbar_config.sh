#!/bin/bash
#
#CONFIG FILE

#Foreground and background colors:
#Foreground is the color of the text, background is the color of the bar itsself. 
foreground_color="#DFB5FF"
background_color="#5B368F"

font=Terminus
font_size=10

font2=FontAwesome
font2_size=10

#The char that seperates all things from each other. I suggest spaces.
seperating_char="   ~   "
#Chars on the end of the bar itself. leave blank for no things.
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


#ADVANCED OPTIONS:
#Script location for lemonbar. This should not need to be touched, as it should be automatic.
#If there are script location movements (such as they are all no longer in the same location), this may break. 
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
lemonbar_path="$SCRIPT_DIR/bar_feeder.sh"

