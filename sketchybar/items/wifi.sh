#!/bin/bash

POPUP_OFF="sketchybar --set wifi popup.drawing=off"

memenu_defaults=(
  popup.blur_radius=32
  popup.background.color=$POPUP_BACKGROUND_COLOR
  popup.background.corner_radius=$PADDINGS
  popup.background.shadow.drawing=on
  popup.background.shadow.color=$BAR_COLOR
  popup.background.shadow.angle=90
  popup.background.shadow.distance=64
)

menu_item_defaults=(
  label.font="$FONT:Regular:12"
  padding_left=$PADDINGS
  padding_right=$PADDINGS
  icon.padding_left=0
  icon.padding_right=4
  icon.color=$HIGHLIGHT
  icon.font.size=13
  background.color=$TRANSPARENT
  scroll_texts=off
  icon.width=16
)

wifi=(
  "${menu_defaults[@]}"
  icon.padding_right=0
  label.drawing=off
  popup.align=right
  update_freq=5
  script="$PLUGIN_DIR/wifi.sh"
  --subscribe wifi wifi_change
                   mouse.clicked
                   mouse.exited
                   mouse.exited.global
)

sketchybar                                                                                            \
  --add item wifi right                                                                               \
  --set wifi "${wifi[@]}"                                                                             \
  --add item wifi.ssid popup.wifi                                                                     \
  --set wifi.ssid icon=􀅴                                                                              \
        label="SSID"                                                                                  \
        "${menu_item_defaults[@]}"                                                                    \
        click_script="open 'x-apple.systempreferences:com.apple.preference.network?Wi-Fi';$POPUP_OFF" \
  --add item wifi.ipaddress popup.wifi                                                                \
  --set wifi.ipaddress icon=􀆪                                                                         \
        label="IP Address"                                                                            \
        "${menu_item_defaults[@]}"                                                                    \
        click_script="echo \"$IP_ADDRESS\"|pbcopy;$POPUP_OFF"
