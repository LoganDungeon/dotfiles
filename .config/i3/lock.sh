#!/bin/bash

rectangles=" "

sr=$(xrandr --query | grep '\bconnected' | grep -o '[0-9][0-9]*x[0-9][0-9]*[^ ]*')

for res in $sr; do
	sra=(${res//[x+]/ })
	cx=$((${sra[2]} + 25))
	cy=$((${sra[1]} - 80))
	rectangles+="rectangle $cx,$cy $((cx+300)),$((cy-80)) "
done

tmpbg=/tmp/screen.png
archicon=$HOME/.config/i3/arch.png
scrot $tmpbg && convert $tmpbg -scale 5% -scale 2000% -draw "fill black fill-opacity 0.4 $rectangles" $tmpbg
convert $tmpbg $archicon -gravity center -composite -matte $tmpbg

i3lock \
 -i $tmpbg \
 --clock --datestr "Type password to unlock..." \
 --insidecolor=00000000 --ringcolor=ffffffff --line-uses-inside \
 --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
 --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
 --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+290:h-120" \
 --radius=20 --ring-width=3 --veriftext="" --wrongtext="" #\
# --textcolor=ffffffff --timecolor=ffffffff --datecolor=ffffffff

rm $tmpbg

#sleep 20 && pgrep i3lock && xset dpms force off
# --timepos="x-90:h-ch-20" \
# --datepos="tx+24:ty+25" \
