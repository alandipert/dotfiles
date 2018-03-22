#!/usr/bin/env bash

WIN=$(xdotool getwindowfocus)
WINX=$(xwininfo -id $WIN|grep 'Absolute upper-left X'|awk '{print $4}')
WINY=$(xwininfo -id $WIN|grep 'Absolute upper-left Y'|awk '{print $4}')
if [[ $WINX != -1 || $WINY != -1 ]]; then
    eval $(xdotool getwindowgeometry --shell $WIN)
    NX=$(expr $WIDTH / 2)
    NY=$(expr $HEIGHT / 2)
    xdotool mousemove --window $WINDOW $NX $NY
fi
