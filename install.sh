#!/bin/bash

set -e

echo "==> Updating system"
sudo pacman -Syu --noconfirm

echo "==> Installing base packages"
sudo pacman -S --noconfirm wget curl gcc make cmake neovim fish kate thunar keepassxc pacman-contrib stow base-devel pybind11

echo "==> Installing yay (AUR helper)"
cd /tmp
rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm

echo "==> Cleaning yay build files"
cd /tmp
rm -rf yay

echo "==> Cloning Caelestia core repo"
git clone https://github.com/caelestia-dots/caelestia.git ~/.local/share/caelestia

echo "==> Running Caelestia installer"
~/.local/share/caelestia/install.fish --vscode=code --discord

# echo "==> Installing caelestia-shell"
# yay -S --noconfirm caelestia-shell-git

echo "==> Configuring Hyprland exec"
mkdir -p ~/.config/hypr/hyprland
echo "exec-once = awww-daemon" >> ~/.config/hypr/hyprland/execs.conf

sudo systemctl enable NetworkManager

echo "==> Switching WiFi backend to iwd"
sudo systemctl disable --now wpa_supplicant || true

sudo bash -c 'cat <<EOF >> /etc/NetworkManager/NetworkManager.conf
[device]
wifi.backend=iwd
EOF'

echo "==> Setting executable scripts (from your repo)"
chmod +x ./caelestia/.config/caelestia/scripts/update.sh || true

echo "==> Applying dotfiles with stow (from your repo)"
rm -rf ~/.config/caelestia
stow caelestia

echo "==> Creating wallpapers symlink"
mkdir -p ~/Pictures
ln -sf ~/.config/caelestia/Wallpapers ~/Pictures/Wallpapers

echo "==> Setting code extension"
chmod +x ./code-extension.sh || true
./code-extension.sh

echo "==> Installation complete!"