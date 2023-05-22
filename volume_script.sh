#!/bin/bash

sound() {
	echo "Volume: %{A:amixer -D pulse sset 'Master' 5%-:}\uf027%{A} | %{A:amixer -D pulse sset 'Master' 5%+:}\uf028%{A}"
}


echo -e "     $(sound)"
sleep 2
