#!/bin/bash

WINDOW_ID=$(xdotool search --onlyvisible --class "Cavalier" | head -n1)

if [ -z "$WINDOW_ID" ]; then
    /usr/bin/flatpak run --branch=stable --arch=x86_64 \
        --command=/app/bin/org.nickvision.cavalier org.nickvision.cavalier &>/dev/null &
    
    # Wait for window to appear and update WINDOW_ID
    while [ -z "$WINDOW_ID" ]; do
        sleep 2
        WINDOW_ID=$(xdotool search --onlyvisible --class "Cavalier" | head -n1)w
    done
fi

# Desired geometry
TARGET_X=1655
TARGET_Y=815
TARGET_W=450
TARGET_H=300

# Get current geometry: x,y,width,height
read CUR_X CUR_Y CUR_W CUR_H < <(xdotool getwindowgeometry --shell "$WINDOW_ID" | awk -F= '
    $1=="X"{x=$2}
    $1=="Y"{y=$2}
    $1=="WIDTH"{w=$2}
    $1=="HEIGHT"{h=$2}
    END{print x, y, w, h}
')

# Only adjust if different
if [ "$CUR_X" != "$TARGET_X" ] || [ "$CUR_Y" != "$TARGET_Y" ] || \
   [ "$CUR_W" != "$TARGET_W" ] || [ "$CUR_H" != "$TARGET_H" ]; then
    xdotool windowsize "$WINDOW_ID" "$TARGET_W" "$TARGET_H"
    xdotool windowmove "$WINDOW_ID" "$TARGET_X" "$TARGET_Y"
fi

xprop -id "$WINDOW_ID" -f _NET_WM_WINDOW_TYPE 32a -set _NET_WM_WINDOW_TYPE _NET_WM_WINDOW_TYPE_DOCK
