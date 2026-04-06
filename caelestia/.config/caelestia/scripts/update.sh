#!/bin/bash

AUR_UPDATES=$(yay -Qu 2>/dev/null)

if [[ -z "$AUR_UPDATES" ]]; then
    notify-send "System" "System is up to date."
    exit 0
fi

notify-send "System" "Starting system update..."

if yay -Syu --noconfirm; then
    notify-send "System" "System updated successfully."
else
    notify-send "System" "Update failed!"
    exit 1
fi