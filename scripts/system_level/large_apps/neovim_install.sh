#!/bin/bash

# install luarocks for lazy.nvim
if ! which luarocks >/dev/null 2>&1; then
    echo "Luarocks is not installed. Installing..."
    sudo apt install -y luarocks
    echo "Luarocks has been installed."
else
    echo "Luarocks is already installed."
fi

# python3-neovim and venv
apt install -y python3-neovim
PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
VENV_PACKAGE="python${PYTHON_VERSION}-venv"
sudo apt install -y $VENV_PACKAGE

if dpkg -l | grep -q $VENV_PACKAGE; then
    echo "$VENV_PACKAGE installed successfully."
else
    echo "Failed to install $VENV_PACKAGE."
fi

mkdir -p ~/ds
wget -O ~/ds/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
tar -xzf ~/ds/nvim.tar.gz -C ~/ds
sudo rm -rf /usr/local/nvim
sudo mkdir -p /usr/local/nvim
sudo mv ~/ds/nvim-linux-x86_64/* /usr/local/nvim
sudo ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim
rm -f ~/ds/nvim.tar.gz
