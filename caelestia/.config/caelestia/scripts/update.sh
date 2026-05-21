#!/bin/bash

echo "Starting system update..."
echo ""

if ! sudo pacman -Syu; then
    notify-send "System" "Pacman update failed!"
    echo "Pacman update failed!"
    exit 1
fi

echo ""
echo "System packages updated."
echo ""

if ! yay -Sua; then
    notify-send "System" "AUR update failed!"
    echo "AUR update failed!"
    exit 1
fi

echo ""
echo "System updated successfully."
notify-send "System" "System updated successfully."

echo ""
echo "Press enter to exit..."
read