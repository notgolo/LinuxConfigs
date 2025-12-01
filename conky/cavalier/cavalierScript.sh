#!/bin/bash

WINDOW_ID=$(xdotool search --onlyvisible --class "Cavalier" | head -n1)

if [ -z "$WINDOW_ID" ]; then
    /usr/bin/flatpak run --branch=stable --arch=x86_64 --command=/app/bin/org.nickvision.cavalier org.nickvision.cavalier &>/dev/null &
    
    # Wait for window to appear and update WINDOW_ID
    while [ -z "$WINDOW_ID" ]; do
        sleep 2
        WINDOW_ID=$(xdotool search --onlyvisible --class "Cavalier" | head -n1)
    done
fi

xdotool windowsize "$WINDOW_ID" 260 305
xdotool windowmove "$WINDOW_ID" 24 277

xprop -id "$WINDOW_ID" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DOCK
