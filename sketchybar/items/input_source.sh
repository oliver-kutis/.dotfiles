
# Setup input source item
sketchybar --add event input_source_change

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

# Setup input source monitoring via shell command subscription
sketchybar --add item input_source right \
           --set input_source icon="􀇳" \
              icon.padding_right=4 \
              icon.color=$TEXT_COLOR \
              label.color=$TEXT_COLOR \
                script="$HOME/.config/sketchybar/plugins/input_source.sh" \
                update_freq=1 \
           --subscribe input_source system_woke front_app_switched space_change
