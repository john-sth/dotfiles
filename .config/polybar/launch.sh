#!/bin/bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use
# polybar-msg cmd quit

# Launch Polybar, using default config location ~/.config/polybar/config.ini
#polybar mainbar 2>&1 | tee -a /tmp/polybar.log & disown
#while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

# Reference: https://github.com/polybar/polybar/issues/763

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    #MONITOR=$m polybar --reload mainbar -c /home/john/.config/polybar/config.ini & 
    MONITOR=$m polybar --reload mainbar & 
  done
else
  polybar --reload mainbar &
  #polybar --reload mainbar -c /home/john/.config/polybar/config.ini &
fi

