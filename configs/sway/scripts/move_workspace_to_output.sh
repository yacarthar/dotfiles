#!/usr/bin/env bash

set -euo pipefail

direction="${1:-next}"
echo "=========" >> /tmp/sway.log
current_ws="$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .name')"
echo "current ws: $current_ws" >> /tmp/sway.log
current_output="$(swaymsg -t get_workspaces | jq -r ".[] | select(.name==\"$current_ws\") | .output")"
echo "current output: $current_output" >> /tmp/sway.log

mapfile -t outputs < <(
    swaymsg -t get_outputs | jq -r '.[] | select(.active) | .name'
)

count="${#outputs[@]}"
echo "count = $count" >> /tmp/sway.log
echo "output: " >> /tmp/sway.log
for o in "${outputs[@]}"; do
    echo "$o" >> /tmp/sway.log
done
echo "---" >> /tmp/sway.log

for i in "${!outputs[@]}"; do
    if [[ "${outputs[$i]}" == "$current_output" ]]; then
        current_index="$i"
        break
    fi
done

case "$direction" in
    next)
        target_index=$(( (current_index + 1) % count ))
        ;;
    prev)
        target_index=$(( (current_index - 1 + count) % count ))
        ;;
    *)
        echo "Usage: $0 {next|prev}" >&2
        exit 1
        ;;
esac

echo "target_index = $target_index" >> /tmp/sway.log
echo "target = ${outputs[$target_index]}" >> /tmp/sway.log
swaymsg move workspace to output "${outputs[$target_index]}"
swaymsg focus output "${outputs[$target_index]}"