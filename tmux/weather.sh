#!/bin/bash
CACHE_FILE="/tmp/tmux_weather_cache"
TTL_MINUTES=30

# Get weather data with proper UTF-8 encoding
get_weather() {
    curl -s 'wttr.in/~cau+giay?format=%t' \
    | sed -e 's/ //g' -e 's/+//g'
}

# Cache logic
if [ -f "$CACHE_FILE" ] && [ -s "$CACHE_FILE" ] && \
   [ $(($(date +%s) - $(stat -c %Y "$CACHE_FILE"))) -lt $(($TTL_MINUTES*60)) ]; then
    cat "$CACHE_FILE"
else
    weather_data=$(get_weather)
    if [ -n "$weather_data" ]; then
        echo "$weather_data" > "$CACHE_FILE"
        echo "$weather_data"
    fi
fi
