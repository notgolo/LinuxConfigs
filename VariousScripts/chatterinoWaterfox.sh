#!/bin/sh

wmctrl -x -r waterfox -b remove,hidden
wmctrl -x -r waterfox -e 0,2245,376,3215,2160
wmctrl -x -a waterfox

wmctrl -x -r chatterino -b remove,hidden
wmctrl -x -r chatterino -e 0,1620,376,625,2160
wmctrl -x -a chatterino
