#!/bin/bash

# This script monitors window changes and triggers the window_change event
# when windows are moved between workspaces

# Store previous window distribution to detect changes
CACHE_DIR="$HOME/.cache/sketchybar"
PREV_WINDOWS_FILE="$CACHE_DIR/prev_windows_state"

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Get current window distribution
current_windows=""
for monitor in $(aerospace list-monitors --format "%{monitor-id}"); do
  for sid in $(aerospace list-workspaces --monitor "$monitor"); do
    windows=$(aerospace list-windows --workspace "$sid" | wc -l)
    current_windows="${current_windows}${sid}:${windows};"
  done
done

# If previous state file doesn't exist, create it
if [ ! -f "$PREV_WINDOWS_FILE" ]; then
  echo "$current_windows" > "$PREV_WINDOWS_FILE"
  # Trigger event to set initial state
  sketchybar --trigger window_change
  # Update workspace icons
  $HOME/.config/sketchybar/plugins/update_workspace_icons.sh
  exit 0
fi

# Read previous state
prev_windows=$(cat "$PREV_WINDOWS_FILE")

# Compare states
if [ "$current_windows" != "$prev_windows" ]; then
  # Update previous state
  echo "$current_windows" > "$PREV_WINDOWS_FILE"
  # Trigger the window_change event
  sketchybar --trigger window_change
  # Update workspace icons
  $HOME/.config/sketchybar/plugins/update_workspace_icons.sh
fi