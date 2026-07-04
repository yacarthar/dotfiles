#!/bin/bash

# 1. Backup existing ds and docs directories
[ -d "$HOME/ds" ] && mv "$HOME/ds" "$HOME/ds.bak"
[ -d "$HOME/docs" ] && mv "$HOME/docs" "$HOME/docs.bak"

# 2. Rename default XDG directories (check if exist and not symlinks)
[ -d "$HOME/Downloads" ] && [ ! -L "$HOME/Downloads" ] && mv "$HOME/Downloads" "$HOME/ds"
[ -d "$HOME/Documents" ] && [ ! -L "$HOME/Documents" ] && mv "$HOME/Documents" "$HOME/docs"

# Ensure target directories exist
mkdir -p "$HOME/ds" "$HOME/docs"

# 3. Restore data from backup (using cp -a to include hidden files)
if [ -d "$HOME/ds.bak" ]; then
    cp -a "$HOME/ds.bak/." "$HOME/ds/"
    rm -rf "$HOME/ds.bak"
fi

if [ -d "$HOME/docs.bak" ]; then
    cp -a "$HOME/docs.bak/." "$HOME/docs/"
    rm -rf "$HOME/docs.bak"
fi

# 4. Create symlinks (only if they do not exist)
[ ! -e "$HOME/Downloads" ] && ln -s "$HOME/ds" "$HOME/Downloads"
[ ! -e "$HOME/Documents" ] && ln -s "$HOME/docs" "$HOME/Documents"

# 5. Move Templates and Public to .local/share
mkdir -p "$HOME/.local/share"
[ -d "$HOME/Templates" ] && mv "$HOME/Templates" "$HOME/.local/share/"
[ -d "$HOME/Public" ] && mv "$HOME/Public" "$HOME/.local/share/"

# Ensure fallback directories exist in .local/share
mkdir -p "$HOME/.local/share/Templates" "$HOME/.local/share/Public"

# 6. Update XDG user dirs configuration
CONF="$HOME/.config/user-dirs.dirs"
touch "$CONF" 

sed -i 's|^XDG_DOWNLOAD_DIR=.*|XDG_DOWNLOAD_DIR="$HOME/ds"|' "$CONF"
sed -i 's|^XDG_DOCUMENTS_DIR=.*|XDG_DOCUMENTS_DIR="$HOME/docs"|' "$CONF"
sed -i 's|^XDG_TEMPLATES_DIR=.*|XDG_TEMPLATES_DIR="$HOME/.local/share/Templates"|' "$CONF"
sed -i 's|^XDG_PUBLICSHARE_DIR=.*|XDG_PUBLICSHARE_DIR="$HOME/.local/share/Public"|' "$CONF"

# 7. Apply changes and verify
xdg-user-dirs-update
xdg-user-dir DOWNLOAD
xdg-user-dir DOCUMENTS
xdg-user-dir TEMPLATES
xdg-user-dir PUBLICSHARE

# killall gjs
