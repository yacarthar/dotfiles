#!/bin/bash

mkdir -p ~/ds
wget -O ~/ds/nvim.tar.gz https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-x86_64.tar.gz
tar -xzf ~/ds/nvim.tar.gz -C ~/ds
sudo rm -rf /usr/local/nvim
sudo mkdir -p /usr/local/nvim
sudo mv ~/ds/nvim-linux-x86_64/* /usr/local/nvim
sudo ln -sf /usr/local/nvim/bin/nvim /usr/local/bin/nvim
rm -f ~/ds/nvim.tar.gz
