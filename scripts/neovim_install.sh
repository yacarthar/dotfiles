#!/bin/bash

# Set variables
NEOVIM_URL="https://github.com/neovim/neovim/releases/download/v0.10.4/nvim-linux-arm64.tar.gz"
DOWNLOAD_DIR="$HOME/ds"
INSTALL_DIR="/usr/local"
SYMLINK_PATH="/usr/local/bin/nvim"
TAR_FILE="$DOWNLOAD_DIR/nvim-linux64.tar.gz"

# Create the download directory if it doesn't exist
mkdir -p "$DOWNLOAD_DIR"

# Download Neovim tar file
echo "Downloading Neovim..."
wget -O "$TAR_FILE" "$NEOVIM_URL"

# Extract and move to /usr/local
echo "Extracting Neovim..."
tar -xzf "$TAR_FILE" -C "$DOWNLOAD_DIR"

# Move extracted files to /usr/local
echo "Installing Neovim..."
sudo mv "$DOWNLOAD_DIR/nvim-linux64" "$INSTALL_DIR/nvim"

# Create symlink
echo "Creating symlink..."
sudo ln -sf "$INSTALL_DIR/nvim/bin/nvim" "$SYMLINK_PATH"

# Remove tar file
echo "Cleaning up..."
rm -f "$TAR_FILE"

echo "Neovim installation complete!"

