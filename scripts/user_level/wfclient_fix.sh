#!/bin/bash

FILE="$HOME/.ICAClient/wfclient.ini"

# Create a backup file
cp "$FILE" "${FILE}.bak"
echo "Created backup: ${FILE}.bak"

echo "--- Step 1: Cleaning up old configurations ---"

# Check and comment out Ctrl+Shift Hotkeys
if grep -q "^\(Hotkey[0-9]*Shift=Ctrl+Shift\)" "$FILE"; then
    echo "[Removed] Commented out conflicting Ctrl+Shift Hotkey lines."
    sed -i 's/^\(Hotkey[0-9]*Shift=Ctrl+Shift\)/# \1/g' "$FILE"
fi

# Function to check if a variable exists, delete it, and print a message
clean_variable() {
    local var_name="$1"
    if grep -q "${var_name}" "$FILE"; then
        echo "[Removed] Deleted old lines containing: ${var_name}"
        sed -i "/${var_name}/d" "$FILE"
    fi
}

# Delete existing target variables to prevent duplicates
clean_variable "TransparentKeyPassthrough"
clean_variable "WCAGModeKeyCombination"
clean_variable "KeyboardEventMode"
clean_variable "KeyboardSyncMode"
clean_variable "MouseSendsControlV"

echo "--- Step 2: Injecting new configurations ---"

# Append the 5 parameters directly under the [WFClient] section
sed -i '/^\[WFClient\]/a TransparentKeyPassthrough=Remote' "$FILE"
sed -i '/^\[WFClient\]/a WCAGModeKeyCombination=' "$FILE"
sed -i '/^\[WFClient\]/a KeyboardEventMode=Scancode' "$FILE"
sed -i '/^\[WFClient\]/a KeyboardSyncMode=No' "$FILE"
sed -i '/^\[WFClient\]/a MouseSendsControlV=False' "$FILE"

echo "[Added] Successfully injected 5 parameters."
echo "Configuration completed!"