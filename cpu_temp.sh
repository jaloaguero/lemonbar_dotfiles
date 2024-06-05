#!/bin/bash
#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh


cpu_temp() {
	cpu_temp=$(sensors|awk 'BEGIN{i=0;t=0;b=0}/id [0-9]/{b=$4};/Core/{++i;t+=$3}END{if(i>0){printf("%0.1f\n",t/i)}else{sub(/[^0-9.]/,"",b);print b}}')

	if [ "${cpu_temp%.*}" -ge 90 ]; then
		echo "%{F$cpu_color_high}${cpu_temp}C%{F$foreground_color} ${cpu_text}"
	elif [ "${cpu_temp%.*}" -ge 65 ]; then
		echo "%{F$cpu_color_med}${cpu_temp}C%{F$foreground_color} ${cpu_text}"
	else
		echo "%{F$cpu_color_low}${cpu_temp}C%{F$foreground_color} ${cpu_text}"
	fi
	}
call_cpu_temp(){

while true
do
	echo "cpu_temp$(cpu_temp)"
	sleep $cpu_temp_refresh_rate
done
}
