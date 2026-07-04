#!/usr/bin/env bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
    exec sudo "$0" "$@"
fi

echo "== Removing Citrix App Protection =="

# service
if systemctl list-unit-files | grep -q '^AppProtectionService-install\.service'; then
    systemctl disable --now AppProtectionService-install.service
    rm -f /etc/systemd/system/AppProtectionService-install.service
    systemctl daemon-reload
fi


# Remove LD_PRELOAD entry
if [[ -f /etc/ld.so.preload ]] &&
    grep -qF "/usr/local/lib/AppProtection/libAppProtection.so" /etc/ld.so.preload; then
    grep -vF "/usr/local/lib/AppProtection/libAppProtection.so" /etc/ld.so.preload > /etc/ld.so.preload.tmp

    if [[ -s /etc/ld.so.preload.tmp ]]; then
        mv /etc/ld.so.preload.tmp /etc/ld.so.preload
    else
        rm -f /etc/ld.so.preload /etc/ld.so.preload.tmp
    fi

    echo "Removed AppProtection from /etc/ld.so.preload."
fi

# Remove AppProtection library
if [[ -d /usr/local/lib/AppProtection ]]; then
    rm -rf /usr/local/lib/AppProtection
    echo "Removed /usr/local/lib/AppProtection"
fi

# Remove dconf policy
rm -f /etc/dconf/db/local.d/00-extensions
rm -f /etc/dconf/db/local.d/locks/extensions
rm -f /etc/dconf/db/local.d/locks/extensions-mandatory

# Rebuild dconf database
if command -v dconf >/dev/null 2>&1; then
    dconf update
    echo "Updated dconf database."
fi

# Refresh linker cache
if command -v ldconfig >/dev/null 2>&1; then
    ldconfig
fi

echo
echo "Cleanup completed."
echo
echo "A reboot or a new login session is recommended."