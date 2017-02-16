#!/usr/bin/env bash

BRIGHTNESS="$(xrandr --verbose|grep Brightness|awk '{print $2}'|tr -d 0.)"
NEW_BRIGHTNESS="$(zenity --entry --title Brightness --entry-text=${BRIGHTNESS} --text='New brightness (1-10):')"
if [[ "$NEW_BRIGHTNESS" == "10" ]]; then
  xrandr --output DP1 --brightness 1
else
  xrandr --output DP1 --brightness "0.${NEW_BRIGHTNESS}"
fi

