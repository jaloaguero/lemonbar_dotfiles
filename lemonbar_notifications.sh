#!/bin/bash

killall test_script.sh

bash ~/.config/lemonbar/volume_script.sh | lemonbar -d -g 260x60+1550+40 -F "#FFFFFF" -B "#140030" -f Terminus-10 -f FontAwesome-10 | $SHELL
