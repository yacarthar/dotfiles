#!/usr/bin/env bash
set -euo pipefail

###############################################################################
# Config
###############################################################################

GO_INSTALL_DIR="/usr/local"
GO_URL="https://go.dev/dl/$(curl -fsSL https://go.dev/VERSION?m=text | head -1).linux-amd64.tar.gz"

###############################################################################
# Prerequisites
###############################################################################

sudo apt update
sudo apt install -y \
    curl \
    git \
    tar \
    ca-certificates \
    build-essential

###############################################################################
# Install Go
###############################################################################

echo "==> Installing Go..."

curl -fsSL "$GO_URL" -o /tmp/go.tar.gz

sudo rm -rf /usr/local/go
sudo tar -C "$GO_INSTALL_DIR" -xzf /tmp/go.tar.gz

###############################################################################
# PATH
###############################################################################

if ! grep -q '/usr/local/go/bin' ~/.profile 2>/dev/null; then
cat >> ~/.profile <<'EOF'

# Go
export PATH="/usr/local/go/bin:$PATH"

# Go tools
export PATH="$PATH:$(go env GOPATH)/bin"
EOF
fi

export PATH="/usr/local/go/bin:$PATH"

###############################################################################
# Install Go tools
###############################################################################

echo "==> Installing gopls..."
go install golang.org/x/tools/gopls@latest

echo "==> Installing delve..."
go install github.com/go-delve/delve/cmd/dlv@latest

export PATH="$PATH:$(go env GOPATH)/bin"

###############################################################################
# Install kubectl
###############################################################################

echo "==> Installing kubectl..."

KVER="$(curl -fsSL https://dl.k8s.io/release/stable.txt)"

curl -fsSLo /tmp/kubectl \
    "https://dl.k8s.io/release/${KVER}/bin/linux/amd64/kubectl"

chmod +x /tmp/kubectl
sudo mv /tmp/kubectl /usr/local/bin/

###############################################################################
# Install kind
###############################################################################

echo "==> Installing kind..."

curl -fsSLo /tmp/kind \
    https://kind.sigs.k8s.io/dl/latest/kind-linux-amd64

chmod +x /tmp/kind
sudo mv /tmp/kind /usr/local/bin/

###############################################################################
# Verify
###############################################################################

echo
echo "========== Versions =========="

go version
echo

gopls version
echo

dlv version
echo

kubectl version --client
echo

kind version
echo

if command -v zed >/dev/null; then
    echo "✓ Zed detected"

    if command -v gopls >/dev/null; then
        echo "✓ gopls detected"
        echo
        echo "Open any Go project with:"
        echo "    zed ."
        echo
        echo "Zed will automatically use gopls."
    else
        echo "✗ gopls not found in PATH"
    fi
else
    echo "⚠ Zed is not installed."
fi

echo
echo "Installation completed."