#!/bin/bash
#
#CONFIG FILE
#==================GENERAL=====================#

bar_dimensions="1920x20"

#Foreground and background colors:
#Foreground is the color of the text, background is the color of the bar itsself. 
foreground_color="#DFB5FF"
background_color="#000000"

font='shuretechmono nerd font'
font_size=10

font2='ShureTechMono Nerd Font'
font2_size=11

#The char that seperates all things from each other. I suggest spaces.
seperating_char="  ~  "
#Chars on the end of the bar itself. leave blank for no things.
edge_char_left=" (/*o*)/ "
edge_char_right="    "

#REFRESH RATE:
#====================WORKSPACE================#
workspace_active_color="#CFBE60"
workspace_back_color='#CF60BD1'
workspace_refresh_rate=0.1
#===================RAM========================#
ram_text="\uf4b3 "
#REMEMBER HIGH = HIGH USAGE, SO FLIP COLORS 
ram_color_high="#8C3535"
ram_color_med="#8C7935"
ram_color_low="#358C5C"
ram_refresh_rate=5
#==================BATTERY=====================#

battery_text_high="\uf240 "
battery_text_med="\uf242 "
battery_text_low="\uf243 "

battery_percent_color_high="#358C5C"
battery_percent_color_med="#8C7935"
battery_percent_color_low="#8C3535"

battery_text_charge="\uf240 "
battery_charge_color="#358C5C"
battery_refresh_rate=10
#=================BRIGHTNESS CONTROL==================#

brightness_text_high="󰃠  "
brightness_text_med="󰃞 "
brightness_text_low="󰃜 "
birghtness_text_none="󰃛 "
brightness_refresh_rate=0.5
#==================DATE=====================#
date_text="\uf133 "
date_refresh_rate=3600
#==================TIME=====================#
time_text="\uf017 "
time_refresh_rate=1
#==================VOLUME=====================#

volume_text_high=" "
volume_text_med=" "
volume_text_low=" "
volume_text_none="\uf466 "
volume_refresh_rate=0.3
#how big the bar is. This is optimized for 1080p
#=====================CPU TEMP======================#
cpu_text="\uf4bc"
cpu_color_high="#8C3535"
cpu_color_med="#8C7935"
cpu_color_low="#358C5C"

cpu_temp_refresh_rate=20
#==================ACTIVE WINDOW TITLE=====================#

active_window_text="\uf4b2"

#Max length of the text. After this length, it will end with '...' so reduce or expand as needed.
max_len=100

active_window_refresh_rate=0.5
#=============ADVANCED OPTIONS=================#
#Script location for lemonbar. This should not need to be touched, as it should be automatic.
#If there are script location movements (such as they are all no longer in the same location), this may break. 
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
lemonbar_path="$SCRIPT_DIR/bar_feeder.sh"

