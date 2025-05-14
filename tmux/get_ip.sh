#!/bin/bash
CACHE_FILE="/tmp/tmux_ip_cache"
TTL_SECONDS=3600  # 1h

# Use cache if valid
if [[ -f "$CACHE_FILE" ]]; then
  cache_age=$(($(date +%s) - $(stat -c %Y "$CACHE_FILE")))
  [[ $cache_age -le $TTL_SECONDS ]] && cat "$CACHE_FILE" && exit
fi

# Get fresh IP and cache it
ip=$(hostname -I | awk '{print $1}')
echo "$ip" > "$CACHE_FILE"
echo "$ip"

