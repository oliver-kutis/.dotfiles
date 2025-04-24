#!/bin/sh

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

# PERCENTAGE=11
PERCENTAGE="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
CHARGING="$(pmset -g batt | grep 'AC Power')"

if [ "$PERCENTAGE" = "" ]; then
  exit 0
fi

case ${PERCENTAGE} in
  9[0-9]|100) ICON="􀛨" ICON_COLOR=$(getcolor green)
  ;;
[6-8][0-9]) ICON="􀺸" ICON_COLOR=$(getcolor green 90)
  ;;
[3-5][0-9]) ICON="􀺶" ICON_COLOR=$(getcolor yellow)
  ;;
[1-2][0-9]) ICON="􀛩" ICON_COLOR=$(getcolor red)
  ;;
  *) ICON="􀛪"
esac

if [[ $CHARGING != "" ]]; then
  ICON="􀢋"
fi

# The item invoking this script (name $NAME) will get its icon and label
# updated with the current battery status
sketchybar --set "$NAME" icon="$ICON" label="${PERCENTAGE}%" \
  icon.color=$ICON_COLOR \
  label.color=$ICON_COLOR 
  # background.color=$ICON_COLOR \
  # background.height=20 \
  # background.corner_radius=10 \
