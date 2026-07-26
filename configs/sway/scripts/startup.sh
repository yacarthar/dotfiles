#!/usr/bin/env bash
set -euo pipefail

ghostty &
ghostty &

zed &

google-chrome --profile-directory=Default &
google-chrome --profile-directory=Default --new-window &
google-chrome --profile-directory="Profile 2" &

wait