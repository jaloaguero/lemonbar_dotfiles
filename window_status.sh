workspaces() {   
    ACTUAL=$(xprop -root _NET_CURRENT_DESKTOP | awk '{printf $3}' ) 
    case $ACTUAL in
      0)
        echo -n "[%{F#$ACTIVE_COLOR}1%{F#$STANDARD_COLOR}][2][3][4][5][6][7][8][9]";;
  
      1)
        echo -n "[1][%{F#$ACTIVE_COLOR}2%{F#$STANDARD_COLOR}][3][4][5][6][7][8][9]";;
  
      2)
        echo -n "[1][2][%{F#$ACTIVE_COLOR}3%{F#$STANDARD_COLOR}][4][5][6][7][8][9]";;
  
      3)
	       echo -n "[1][2][3][%{F#$ACTIVE_COLOR}4%{F#$STANDARD_COLOR}][5][6][7][8][9]";;
  
      4)
        echo -n "[1][2][3][4][%{F#$ACTIVE_COLOR}5%{F#$STANDARD_COLOR}][6][7][8][9]";;
  
      5)
        echo -n "[1][2][3][4][5][%{F#$ACTIVE_COLOR}6%{F#$STANDARD_COLOR}][7][8][9]";;
  
      6)
        echo -n "[1][2][3][4][5][6][%{F#$ACTIVE_COLOR}7%{F#$STANDARD_COLOR}][8][9]";;
  
  
      7)
        echo -n "[1][2][3][4][5][6][7][%{F#$ACTIVE_COLOR}8%{F#$STANDARD_COLOR}][9]";;
  
  
      8)
        echo -n "[1][2][3][4][5][6][7][8][%{F#$ACTIVE_COLOR}9%{F#$STANDARD_COLOR}]";;
  
    esac
  
  }
