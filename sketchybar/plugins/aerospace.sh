#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

# Get the current focused workspace from aerospace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused | head -n 1)
CURRENT_WORKSPACE=${NAME#*.}

if [ "$CURRENT_WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
                       background.height=20 \
                       background.color=$ITEM_BG_COLOR \
                       label.color=$ACCENT_COLOR \
                       icon.color=$ACCENT_COLOR
else
  sketchybar --set $NAME background.drawing=off \
                       background.height=20 \
                       background.color=$(getcolor zaitra_green 10) \
                       label.color=$ALT_TEXT_COLOR \
                       icon.color=$ALT_TEXT_COLOR 
fi