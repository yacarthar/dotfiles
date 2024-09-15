#!/bin/bash

PYTHON_VERSION=$(python3 -c "import sys; print(f'{sys.version_info.major}.{sys.version_info.minor}')")
VENV_PACKAGE="python${PYTHON_VERSION}-venv"

sudo apt update
sudo apt install -y $VENV_PACKAGE

if dpkg -l | grep -q $VENV_PACKAGE; then
    echo "$VENV_PACKAGE installed successfully."
else
    echo "Failed to install $VENV_PACKAGE."
fi

