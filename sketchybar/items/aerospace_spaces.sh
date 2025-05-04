# Add the aerospace_workspace_change event we specified in aerospace.toml
sketchybar --add event aerospace_workspace_change

# Add workspaces for all monitors
for monitor in $(aerospace list-monitors --format "%{monitor-id}"); do
  for sid in $(aerospace list-workspaces --monitor "$monitor"); do
    # Determine which display this workspace should be shown on
    display_id="1"
    # Ensure sid is treated as an integer by using arithmetic comparison (())
    if (( sid >= 6 )) && (( sid <= 7 )); then
      display_id="2"
    fi
    
    sketchybar --add space space.$sid left                                 \
                --set space.$sid display="$display_id" \
                --subscribe space.$sid aerospace_workspace_change \
                --set space.$sid \
                  drawing=on \
                  space=$sid                                 \
                  icon=$sid                                  \
                  label.font="sketchybar-app-font:Regular:14.0" \
                  label.padding_right=20                     \
                  label.y_offset=-1                          \
                  background.corner_radius=8                 \
                  label.background.drawing=on \
                  script="$PLUGIN_DIR/aerospace.sh" \
                  click_script="aerospace workspace $sid"
  done
done

sketchybar --add item space_separator left                             \
            --subscribe space_separator aerospace_workspace_change \
            --set space_separator icon="􁀘"                               \
                                  icon.color=$ALT_TEXT_COLOR \
                                  icon.padding_left=3                   \
                                  label.drawing=off                     \
                                  background.drawing=off                \
                                  script="$PLUGIN_DIR/aerospace_space_windows.sh"

source $PLUGIN_DIR/update_workspace_icons.sh