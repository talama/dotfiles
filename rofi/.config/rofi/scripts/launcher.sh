#!/bin/bash

menu="$1"

if [ "$menu" = "powermenu" ]; then
    rofi -modi 'Powermenu:~/.config/rofi/scripts/powermenu.sh' -show Powermenu -theme powermenu
fi
