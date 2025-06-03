# Add the aerospace_workspace_change event we specified in aerospace.toml
sketchybar --add event aerospace_workspace_change

# Create a left item group for each monitor
for monitor in $(aerospace list-monitors --format "%{monitor-id}"); do
  # Get the display ID for this monitor
  display_id=$(aerospace list-monitors --format "%{monitor-appkit-nsscreen-screens-id}" | grep -n "^$monitor$" | cut -d: -f1)
  
  # # Create a separator for this monitor's spaces
  # sketchybar --add item spaces.${monitor}.separator left \
  #            --set spaces.${monitor}.separator \
  #                 label="${display_id}" \
  #                 label.color=$ALT_TEXT_COLOR \
  #                 padding_right=20 \
  #                 padding_left=5 \
  #                 icon="􀈉" \
  #                 icon.color=$ALT_TEXT_COLOR \
  #                 icon.drawing=on \
  #                 drawing=on \
  #                 display="${display_id}"
  
  
  # Add workspaces for this monitor
  for sid in $(aerospace list-workspaces --monitor "$monitor"); do
    sketchybar --add space space.$sid left \
              --set space.$sid \
                  space=$sid \
                  icon=$sid \
                  display="${display_id}" \
                  drawing=on \
                  label.font="sketchybar-app-font:Regular:14.0" \
                  label.padding_right=20 \
                  label.y_offset=-1 \
                  background.corner_radius=8 \
                  label.background.drawing=on \
                  script="$PLUGIN_DIR/aerospace.sh" \
                  click_script="aerospace workspace $sid" \
              --subscribe space.$sid aerospace_workspace_change window_change
  done
done

# Add space separator that shows app icons
sketchybar --add item space_separator left \
           --subscribe space_separator aerospace_workspace_change \
           --set space_separator icon="􀆊" \
                                icon.color=$(getcolor black) \
                                icon.padding_left=3 \
                                label.drawing=off \
                                background.drawing=off \
                                script="$PLUGIN_DIR/aerospace_space_windows.sh"

# Update workspace icons for all spaces
source $PLUGIN_DIR/update_workspace_icons.sh