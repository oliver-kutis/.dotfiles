#!/bin/bash

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

sketchybar --set $NAME label="$(date +'%a, %d %b  %H:%M')" \
  label.color=$TEXT_COLOR \
  icon.color=$TEXT_COLOR
