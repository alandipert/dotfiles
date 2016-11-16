#!/usr/bin/env bash
# Pass no argument to toggle mute.  Pass integer argument with + suffix to increase volume, - suffix to decrease.  Example:
# volume.sh # mute
# volume.sh 5+ # increase by 5%
# volume.sh 5- # decrease by 5%
set -e
if [ -z "$1" ]; then
  amixer -q -D pulse sset Master toggle
  if $(amixer sget Master|tail -1|grep on); then
    notify-send "Unmuted"
  else
    notify-send "Muted"
  fi
else
  amixer -q sset Master,0 $1 unmute
  VOLUME=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))
  notify-send "Volume: $VOLUME"
fi
