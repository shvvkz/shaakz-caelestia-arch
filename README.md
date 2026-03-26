# Caelestia Dotfiles Setup (Arch Linux)

## Overview

This repository contains my personal dotfiles built on top of the Caelestia ecosystem.

Important:
This setup depends on the official Caelestia repository, which will be cloned separately during installation.

---

## Requirements

* Fresh Arch Linux install (recommended via `archinstall`)
* Internet connection
* A user with sudo privileges
* git

---

## Installation

### 1. Clone this repository into your home directory

```bash
git clone https://github.com/shvvkz/shaakz-caelestia-arch.git ~/shaakz-caelestia-arch
cd ~/shaakz-caelestia-arch
```

---

### 2. Run the installation script

```bash
chmod +x install.sh
./install.sh
```

---

## What the script does

* Updates the system
* Installs base packages
* Installs yay (AUR helper)
* Clones the official Caelestia repository into:

  ```
  ~/.local/share/caelestia
  ```
* Runs the Caelestia installer
* Installs `caelestia-shell-git`
* Applies your personal dotfiles using GNU Stow
* Configures system components (Hyprland, NetworkManager, etc.)

## After installation

Reboot:

```bash
reboot
```
