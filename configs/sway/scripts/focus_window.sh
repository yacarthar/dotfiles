#!/usr/bin/env bash

set -euo pipefail

direction="${1:-next}"

tree="$(swaymsg -t get_tree)"

workspace=$(
    swaymsg -t get_workspaces |
    jq -r '.[] | select(.focused) | .name'
)

mapfile -t ids < <(
    jq -r --arg ws "$workspace" '
        recurse(.nodes[]?, .floating_nodes[]?)
        | select(.type == "workspace" and .name == $ws)
        | recurse(.nodes[]?, .floating_nodes[]?)
        | select(.pid != null)
        | .id
    ' <<<"$tree"
)

current="$(
    jq -r '
        recurse(.nodes[]?, .floating_nodes[]?)
        | select(.focused)
        | .id
    ' <<<"$tree"
)"

count="${#ids[@]}"
(( count > 1 )) || exit 0

for i in "${!ids[@]}"; do
    [[ "${ids[$i]}" == "$current" ]] && current_index="$i"
done

case "$direction" in
    next) target=$(( (current_index + 1) % count )) ;;
    prev) target=$(( (current_index - 1 + count) % count )) ;;
    *) exit 1 ;;
esac

swaymsg "[con_id=${ids[$target]}]" focus >/dev/null