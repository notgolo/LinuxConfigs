#!/bin/bash

# Search for visible rofi window ID
wid=$(xdotool search --onlyvisible --class rofi | head -n 1)

if [ -n "$wid" ]; then
    # Kill the rofi window
    xdotool windowclose "$wid"
else
    # Launch rofi
    rofi -show drun &
fi

