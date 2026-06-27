#!/bin/bash

# Check root privileges
if [ "$EUID" -ne 0 ]; then
  echo "Error: Please run this script with root privileges (sudo)!"
  exit 1
fi

# Define path for DEB822 formatted APT sources
TARGET_FILE="/etc/apt/sources.list.d/ubuntu.sources"

if [ ! -f "$TARGET_FILE" ]; then
    echo "Error: Configuration file $TARGET_FILE not found."
    exit 1
fi

# Define mirrors to benchmark
declare -A MIRRORS
MIRRORS=(
    ["bizfly"]="http://mirror.bizflycloud.vn/ubuntu/"
    ["azvps"]="https://mirror.azvps.vn/ubuntu/"
    ["vhost"]="https://vn-mirrors.vhost.vn/ubuntu/"
    ["clearsky"]="https://mirror.clearsky.vn/ubuntu/"
)

best_mirror=""
best_time=999

echo "===== Benchmarking Mirror Connection Latency ====="

for name in "${!MIRRORS[@]}"; do
    url="${MIRRORS[$name]}"
    # Measure TCP connection time using curl
    response_time=$(curl -o /dev/null -s -w "%{time_connect}\n" --connect-timeout 2 "$url")

    # Verify if connection succeeded (returns > 0)
    if (( $(echo "$response_time > 0" | bc -l) )); then
        echo "- $name ($url): ${response_time}s"
        # Track the lowest latency mirror
        if (( $(echo "$response_time < $best_time" | bc -l) )); then
            best_time=$response_time
            best_mirror=$url
            best_name=$name
        fi
    else
        echo "- $name ($url): Connection failed (Timeout/Offline)"
    fi
done

echo "----------------------------------------------------"

# Apply changes if a functional mirror is found
if [ -n "$best_mirror" ]; then
    echo "==> Best mirror found: $best_name with latency ${best_time}s"

    # Create backup file
    cp "$TARGET_FILE" "${TARGET_FILE}.bak"
    echo "[V] Backup file created at ${TARGET_FILE}.bak"

    # Replace all URIs blocks with the fastest repository endpoint
    sed -i "s|^URIs: .*|URIs: $best_mirror|g" "$TARGET_FILE"

    echo "[V] APT mirror successfully updated to: $best_mirror"
    echo "Running 'apt update' to apply changes..."
    apt update
else
    echo "[X] No available mirrors detected. Keeping original configuration intact."
fi