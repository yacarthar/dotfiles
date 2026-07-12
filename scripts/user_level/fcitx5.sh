#!/usr/bin/env bash

set -euo pipefail

if [[ "${XDG_SESSION_DESKTOP:-}" != "sway" ]]; then
    echo "Error: This script must be run inside a Sway session."
    exit 1
fi

echo "Updating package index..."
sudo apt update &> /dev/null

echo "Installing fcitx5..."
sudo apt install -y \
    fcitx5 \
    fcitx5-bamboo \
    fcitx5-configtool \
    fcitx5-frontend-gtk3 \
    fcitx5-frontend-gtk4 \
    fcitx5-frontend-qt5 \
    fcitx5-frontend-qt6

echo
fcitx5 -v
echo

mkdir -p "$HOME/.config/environment.d"

cat >"$HOME/.config/environment.d/fcitx5.conf" <<'EOF'
GTK_IM_MODULE=fcitx
QT_IM_MODULE=fcitx
XMODIFIERS=@im=fcitx
SDL_IM_MODULE=fcitx
EOF

grep -qxF 'exec fcitx5 -d' "$HOME/.config/sway/config" || \
    echo 'exec fcitx5 -d' | tee -a "$HOME/.config/sway/config" >/dev/null

echo
echo "Installation completed."
echo "Please log in again to activate fcitx5"

