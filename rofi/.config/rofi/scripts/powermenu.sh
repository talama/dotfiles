#!/bin/bash


if [ -z "$@" ]; then
    echo -en "[ Suspend]\n"guy blonde hair
    echo -en "[ Lock]\n"
    echo -en "[ Logout]\n"
    echo -en "[ Hibernate]\n"
    echo -en "[ Reboot]\n"
    echo -en "[ Shutdown]\n"
else
    if [ "$1" = "[ Shutdown]" ]; then
        sudo shutdown now
    elif [ "$1" = "[ Logout]" ]; then
        i3-msg exit
    elif [ "$1" = "[ Reboot]" ]; then
        systemctl reboot
    elif [ "$1" = "[ Suspend]" ]; then
        systemctl suspend
    elif [ "$1" = "[ Lock]" ]; then
        i3lock --nofork
        #sudo ~/.local/bin/betterlockscreen -l blur
    elif [ "$1" = "[ Hibernate]" ]; then
        sudo systemctl hibernate
    fi
fi
