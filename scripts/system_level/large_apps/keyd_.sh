#!/usr/bin/env bash

set -euo pipefail

sudo apt update
sudo apt install -y keyd

sudo mkdir -p /etc/keyd

sudo tee /etc/keyd/default.conf >/dev/null <<'EOF'
[ids]
*

[main]
capslock = right
EOF

sudo systemctl enable --now keyd
sudo systemctl restart keyd

echo "Done."
systemctl --no-pager --full status keyd