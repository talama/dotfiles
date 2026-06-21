#!/bin/bash
if [ -z "$@" ]; then
  echo -en "[ Suspend]\n"
  echo -en "[ Lock]\n"
  echo -en "[ Logout]\n"
  echo -en "[ Hibernate]\n"
  echo -en "[ Reboot]\n"
  echo -en "[ Poweroff]\n"
else
  if [ "$1" = "[ Poweroff]" ]; then
    poweroff
  elif [ "$1" = "[ Logout]" ]; then
    swaymsg exit
  elif [ "$1" = "[ Reboot]" ]; then
    systemctl reboot
  elif [ "$1" = "[ Suspend]" ]; then
    systemctl suspend
  elif [ "$1" = "[ Lock]" ]; then
    i3lock --nofork
    #sudo ~/.local/bin/betterlockscreen -l blur
  elif [ "$1" = "[ Hibernate]" ]; then
    systemctl hibernate
  fi
fi
