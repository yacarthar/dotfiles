#!/bin/bash

# Process each pane
tmux list-panes -F '#{pane_id} #{pane_current_command}' | \
while read -r pane_id pane_command; do
  # Skip common interactive programs (case insensitive)
  if [[ ! "${pane_command,,}" =~ (vim|nano|emacs|htop|less|man|ssh|mysql|python|ruby|irb|pry) ]]; then
    tmux send-keys -t "$pane_id" "source ~/.bashrc" Enter
  fi
done

# Show completion message
tmux display-message "Safely reloaded .bashrc in compatible panes"
