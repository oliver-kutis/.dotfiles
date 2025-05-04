#!/bin/bash

KEYBOARD_LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | egrep -w 'KeyboardLayout Name' | sed -E 's/^.+ = \"?([^\"]+)\"?;$/\1/')

if [[ -z $KEYBOARD_LAYOUT ]]; then
  KEYBOARD_LAYOUT=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleSelectedInputSources | grep "InputSourceKind" -A 1 | grep "KeyboardLayout" | awk -F\" '{print $4}')
fi

sketchybar --set $NAME label="$KEYBOARD_LAYOUT" 
