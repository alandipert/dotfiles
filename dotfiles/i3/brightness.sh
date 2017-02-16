#!/usr/bin/env bash

BRIGHTNESS="$(xrandr --verbose|grep Brightness|awk '{print $2}')"

case $1 in
  up) ADJUSTMENT="+0.1" ;;
  down) ADJUSTMENT="-0.1" ;;
  *) exit 1 ;;
esac

NEW_BRIGHTNESS="$(echo ${BRIGHTNESS}${ADJUSTMENT}|bc)"

if [[ $(echo "$NEW_BRIGHTNESS <= 0"|bc) == 1 ]]; then
  xrandr --output DP1 --brightness 0
elif [[ $(echo "$NEW_BRIGHTNESS >= 1"|bc) == 1 ]]; then
  xrandr --output DP1 --brightness 1
else
  xrandr --output DP1 --brightness $NEW_BRIGHTNESS
fi
