#!/bin/bash

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "==> Updating system"
sudo pacman -Syu --noconfirm

echo "==> Installing base packages"
sudo pacman -S --noconfirm wget curl gcc make cmake neovim fish kate thunar keepassxc pacman-contrib stow base-devel pybind11 firefox ttf-fira-code 
yay -S code-marketplace

if ! command -v yay &> /dev/null; then
    cd /tmp
    rm -rf yay
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    rm -rf /tmp/yay 
else
    echo "==> yay already installed, skipping"
fi

CAELESTIA_DIR="$HOME/.local/share/caelestia"

if [ ! -d "$CAELESTIA_DIR" ]; then
    git clone https://github.com/caelestia-dots/caelestia.git "$CAELESTIA_DIR"
    fish "$CAELESTIA_DIR/install.fish" --vscode=code --discord
    # echo "==> Installing caelestia-shell"
    # yay -S --noconfirm caelestia-shell-git
else
    echo "==> Caelestia already installed, skipping"
fi

mkdir -p ~/.config/hypr/hyprland
grep -qxF "exec-once = awww-daemon" ~/.config/hypr/hyprland/execs.conf 2>/dev/null || \
echo "exec-once = awww-daemon" >> ~/.config/hypr/hyprland/execs.conf

sudo systemctl enable NetworkManager

sudo systemctl disable --now wpa_supplicant || true

if ! grep -q "wifi.backend=iwd" /etc/NetworkManager/NetworkManager.conf 2>/dev/null; then
    sudo bash -c 'cat <<EOF >> /etc/NetworkManager/NetworkManager.conf
[device]
wifi.backend=iwd
EOF'
fi

cd "$SCRIPT_DIR"

chmod +x ./caelestia/.config/caelestia/scripts/update.sh || true

rm -rf ~/.config/caelestia
stow caelestia

if [ -f "./code-extension.sh" ]; then
    chmod +x ./code-extension.sh
    ./code-extension.sh
fi

mkdir -p ~/Pictures
ln -sf ~/.config/caelestia/Wallpapers ~/Pictures/Wallpapers

rm ~/.config/Code\ -\ OSS/User/settings.json
ln -sf ~/.config/caelestia/vscode_user_settings.json ~/.config/Code\ -\ OSS/User/settings.json

echo "" >> ~/.bash_profile
echo 'if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then' >> ~/.bash_profile
echo '    exec start-hyprland' >> ~/.bash_profile
echo 'fi' >> ~/.bash_profile

echo "==> Installation complete!"