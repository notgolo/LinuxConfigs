#!/bin/bash
status=$(nordvpn status | grep -i "Status:" | awk '{print $2}')
if [ "$status" == "Connected" ]; then
    echo "on"
else
    echo "off"
fi
