#!/usr/bin/env bash

set -euo pipefail

FONT_URL="https://font.download/dl/font/fira-code-2.zip"
TMP_DIR="$(mktemp -d)"

# trap 'rm -rf "$TMP_DIR"' EXIT

mkdir -p "$HOME/.local/share/fonts"

curl -L "$FONT_URL" -o "$TMP_DIR/fira-code.zip"

mkdir -p "$TMP_DIR/extract"
unzip -q "$TMP_DIR/fira-code.zip" -d "$TMP_DIR/extract"

cp -r "$TMP_DIR/extract" "$HOME/.local/share/fonts/"

fc-cache -f
fc-list | grep -i "fira"

echo "Fira Code installed successfully."
