#!/bin/bash

# 1. Check if the script is run with root privileges (sudo)
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script as root"
  exit 1
fi

GRUB_FILE="/etc/default/grub"

# 2. Backup the current configuration file before editing
cp "$GRUB_FILE" "${GRUB_FILE}.bak"
echo "Original file backed up to ${GRUB_FILE}.bak"

# 3. Use sed to change the values of STYLE and TIMEOUT
sed -i 's/^GRUB_TIMEOUT_STYLE=.*/GRUB_TIMEOUT_STYLE=menu/' "$GRUB_FILE"
sed -i 's/^GRUB_TIMEOUT=.*/GRUB_TIMEOUT=4/' "$GRUB_FILE"

# 4. Check and add/modify GRUB_RECORDFAIL_TIMEOUT
if grep -q "^GRUB_RECORDFAIL_TIMEOUT=" "$GRUB_FILE"; then
    # If the line exists, use sed to replace its value with 0
    sed -i 's/^GRUB_RECORDFAIL_TIMEOUT=.*/GRUB_RECORDFAIL_TIMEOUT=0/' "$GRUB_FILE"
else
    # If it does not exist, append it to the end of the file
    echo 'GRUB_RECORDFAIL_TIMEOUT=0' >> "$GRUB_FILE"
fi

echo "Successfully modified $GRUB_FILE."

# 5. Apply the changes
echo "Updating GRUB..."
update-grub

echo "Done! The new GRUB configuration has been applied."