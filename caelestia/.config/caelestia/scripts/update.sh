#!/bin/bash

UPDATES=$(checkupdates 2>/dev/null)
AUR_UPDATES=$(yay -Qua 2>/dev/null)

if [[ -n "$UPDATES" || -n "$AUR_UPDATES" ]]; then
    notify-send "System" "Starting system update..."
else
    notify-send "System" "System is up to date."
    exit 0
fi

sudo pacman -Syu --noconfirm
yay -Syu --noconfirm

notify-send "System" "System updated."
