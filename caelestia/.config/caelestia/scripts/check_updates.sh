#!/bin/bash

# Vérification des updates
if ! UPDATES=$(yay -Qu 2>/dev/null); then
    notify-send "System" "Failed to check updates"
    exit 1
fi

if [[ -z "$UPDATES" ]]; then
    notify-send "System" "System is up to date."
    exit 0
fi

notify-send "System" "Updates available. Launching updater..."

loginctl enable-linger shaakz

systemd-run --user --scope --tty \
    env DISPLAY=:0 WAYLAND_DISPLAY=wayland-0 \
    XDG_RUNTIME_DIR=/run/user/1000 \
    foot -e /home/shaakz/.config/caelestia/scripts/updates.sh