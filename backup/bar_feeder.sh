#!/bin/sh

clock() {
	date
}

while true
do 
	BAR_INPUT="%{c}TIME : $(clock)"
	echo $BAR_INPUT
	sleep 1
done


