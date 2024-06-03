#!/bin/bash
#Gets absolute path of config file, and sources it.
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/lemonbar_config.sh


cpu_temp() {
	
	echo $(sensors|awk 'BEGIN{i=0;t=0;b=0}/id [0-9]/{b=$4};/Core/{++i;t+=$3}END{if(i>0){printf("%0.1f\n",t/i)}else{sub(/[^0-9.]/,"",b);print b}}') ${CPU_TEMP}

}
call_cpu_temp(){

while true
do
	echo "cpu_temp$(cpu_temp)"
	sleep $cpu_temp_refresh_rate
done
}
