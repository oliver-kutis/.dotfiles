#!/bin/bash

SPACE_SIDS=(1 2 3 4 5 6 7 8 9 10)

for sid in "${SPACE_SIDS[@]}"
do
  sketchybar --add space space.$sid left                                 \
             --set space.$sid space=$sid                                 \
                              icon=$sid                                  \
                              label.font="sketchybar-app-font:Regular:14.0" \
                              label.padding_right=20                     \
                              label.y_offset=-1                          \
                              background.corner_radius=8                 \
                              label.background.drawing=on \
                              script="$PLUGIN_DIR/space.sh"
done

sketchybar --add item space_separator left                             \
           --set space_separator icon="􀆊"                               \
                                 icon.color=$ACCENT_COLOR \
                                 icon.padding_left=4                   \
                                 label.drawing=off                     \
                                 background.drawing=off                \
                                 script="$PLUGIN_DIR/space_windows.sh" \
           --subscribe space_separator space_windows_change

sketchybar --add bracket spaces '/space\/..*/'                         \
           --set spaces background.color=$BAR_COLOR  \
                        background.corner_radius=4 \
                        background.height=20 \
                        background.drawing=on
                

