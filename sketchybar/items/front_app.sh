#!/bin/bash

sketchybar --add item front_app left \
           --set front_app       background.color=$ITEM_BG_COLOR \
                                 background.height=20 \
                                 background.corner_radius=8     \
                                 icon.color=$TEXT_COLOR \
                                 icon.font="sketchybar-app-font:Regular:14.0" \
                                 label.color=$TEXT_COLOR \
                                 script="$PLUGIN_DIR/front_app.sh"            \
           --subscribe front_app front_app_switched
