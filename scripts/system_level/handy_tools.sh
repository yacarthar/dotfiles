#!/bin/bash

# 1. Ensure the script is run with root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with root privileges (sudo)!"
  exit 1
fi

echo "=================================================="
echo "         System Initialization & Tools            "
echo "=================================================="

# 2. Fix potential dpkg locks or interrupted installs
echo "Checking for broken packages..."
dpkg --configure -a

# 3. Optimize APT: Run update quietly
echo "Updating APT package lists..."
apt-get update &> /dev/null

# 4. Define the complete list of packages to install
PACKAGES=(
    "curl"
    "unzip"
    "git"
    "vim"
    "tmux"
    # find
    "ripgrep"
    "silversearcher-ag"
	"fzf"
    # UI
    "software-properties-gtk"
    "gnome-shell-extension-manager"
    "btop"
    "tree"
    "fastfetch"
    # unneccessary
    "xclip"
    "zsh"
    "build-essential"
)

echo "--------------------------------------------------"
echo "Processing package installations:"

# 5. Smart Loop: Check before install to save time and bandwidth
for pkg in "${PACKAGES[@]}"; do
    echo -n "- $pkg... "
    if dpkg -l | grep -q "^ii  $pkg " 2>/dev/null; then
        echo "[Already Installed]"
    else
        echo -n "[Installing] "
        # Install quietly but capture errors if any occur
        if apt-get install -y "$pkg" &> /dev/null; then
            echo "-> [Success]"
        else
            echo "-> [FAILED]"
        fi
    fi
done

# 6. Post-installation cleanup to free disk space
echo "--------------------------------------------------"
echo "Cleaning up residual package caches..."
apt-get autoremove -y &> /dev/null
apt-get clean &> /dev/null

echo "=================================================="
echo "Basic environment setup completed successfully."