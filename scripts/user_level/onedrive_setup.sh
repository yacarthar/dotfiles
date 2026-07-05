#!/bin/bash

# Ensure the script is NOT run directly as root
if [ "$EUID" -eq 0 ]; then
  echo "Error: Do not run this script with sudo directly!"
  echo "Run it as a regular user: ./install_onedrive.sh"
  exit 1
fi


# --------------------------------------------------
# STEP 1: User Configuration Files
# --------------------------------------------------
echo "Generating local configuration directories..."
mkdir -p ~/.config/onedrive

echo "Configuring sync_list filter rules..."
echo "/away" >> ~/.config/onedrive/sync_list

echo "Configuring sync_dir ..."
echo "threads = \"4\"" >> ~/.config/onedrive/config
echo "sync_dir = \"~/onedrive\"" >> ~/.config/onedrive/config

# --------------------------------------------------
# STEP 2: Authentication & Sync Verification Flow
# --------------------------------------------------
echo -e "\n=================================================="
echo "          Authentication & Verification           "
echo "=================================================="
echo "Step A: Authentication Link Generation."
echo "Please click the link below, log in, and copy the final blank URL back here."
echo "--------------------------------------------------"

# Trigger authorization URL prompt cleanly
onedrive --display-config &> /dev/null # Minor verification
onedrive

echo "--------------------------------------------------"
echo "Step B: Executing Simulation (Dry-Run)..."
onedrive --sync --dry-run

# echo "--------------------------------------------------"
# echo "Step C: Running Initial Production Sync..."
# onedrive --sync
# onedrive --resync

echo "=================================================="
echo "OneDrive installation and initialization complete."