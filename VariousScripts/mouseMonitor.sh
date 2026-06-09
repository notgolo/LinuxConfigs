#!/bin/bash

MOUSE="Endgame Gear Endgame Gear OP1 8k Gaming Mouse"

# wait a moment for X and input devices to finish initializing
sleep 5

# mouse settings
xinput set-prop "$MOUSE" "libinput Accel Speed" 0
xinput set-prop "$MOUSE" "libinput Accel Profile Enabled" 0, 1, 0

# disable screen blanking and DPMS
xset s off
xset -dpms
