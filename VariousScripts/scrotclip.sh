#!/bin/sh
scrot -u /tmp/screenshot.png -e 'xclip -selection clipboard -t image/png -i $f'
