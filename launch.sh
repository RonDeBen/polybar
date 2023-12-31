#!/usr/bin/env bash

# Add this script to your wm startup file.

DIR="$HOME/.config/polybar"

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Define your monitors
primary_monitor="DP-2-2"
laptop_monitor="eDP-1"
secondary_monitor="DP-2-3"

# Check if monitors are connected
primary_connected=$(xrandr --query | grep "$primary_monitor connected")
laptop_connected=$(xrandr --query | grep "$laptop_monitor connected")
secondary_connected=$(xrandr --query | grep "$secondary_monitor connected")

# Function to launch bar
launch_bar() {
  MONITOR=$1 polybar -q $2 -c "$DIR"/config.ini &
}

# Launch Polybar based on monitor connection
if [ "$primary_connected" ]; then
    launch_bar $primary_monitor main
fi

if [ "$laptop_connected" ]; then
    launch_bar $laptop_monitor secondary
fi

if [ "$secondary_connected" ]; then
    launch_bar $secondary_monitor vert
fi
