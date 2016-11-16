#!/usr/bin/env bash
# Pass no argument to toggle mute.  Pass integer argument with + suffix to increase volume, - suffix to decrease.  Example:
# volume.sh # mute
# volume.sh 5+ # increase by 5%
# volume.sh 5- # decrease by 5%
if [ -z "$1" ]; then
  amixer -q -D pulse sset Master toggle
else
  amixer -q sset Master,0 $1 unmute
fi
