#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

# Get the current focused workspace from aerospace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused | head -n 1)
CURRENT_WORKSPACE=${NAME#*.}

# if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
if [ "$CURRENT_WORKSPACE" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME background.drawing=on \
                       background.height=20 \
                       background.color=$ITEM_BG_COLOR \
                       label.color=$(getcolor white) \
                       icon.color=$(getcolor white) \
                       background.clip=1
else
  sketchybar --set $NAME background.drawing=off \
                       label.color=$(getcolor black) \
                       icon.color=$(getcolor black) \
                       background.color=$(getcolor white 50) \
                       background.height=20
fi
