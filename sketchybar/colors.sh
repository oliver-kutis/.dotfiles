
export WHITE=0xffffffff
export TRANSPARENT=0x00000000
export BACKGROUND_1=0x603c3e4f
export BACKGROUND_2=0x60494d64

# Catpuccin Mocha https://github.com/catppuccin/catppuccin#-palette
CATPUCCIN=(
  blue "#89b4fa"
  teal "#94e2d5"
  cyan "#89dceb"
  grey "#585b70"
  green "#a6e3a1"
  yellow "#f9e2af"
  orange "#fab387"
  red "#f38ba8"
  purple "#cba6f7"
  maroon "#eba0ac"
  black "#1e1e2e"
  trueblack "#000000"
  white "#cdd6f4"
  true_white "#ffffff"
  zaitra_green "#1ED760"
)


COLORS=("${CATPUCCIN[@]}")

getcolor() {
  COLOR_NAME=$1
  local COLOR=""

  if [[ -z $2 ]]; then
    OPACITY=100
  else
    OPACITY=$2
  fi

  # Loop through the array to find the color hex by name
  for ((i = 0; i < ${#COLORS[@]}; i += 2)); do
    if [[ "${COLORS[i]}" == "$COLOR_NAME" ]]; then
      COLOR="${COLORS[i + 1]}"
      break
    fi
  done

  # Check if color was found
  if [[ -z $COLOR ]]; then
    echo "Invalid color name: $COLOR_NAME" >&2
    return 1
  fi

  echo $(PERCENT2HEX $OPACITY)${COLOR:1}
}

PERCENT2HEX() {
  local PERCENTAGE=$1
  local DECIMAL=$(((PERCENTAGE * 255) / 100))
  printf "0x%02X\n" "$DECIMAL"
}

export ALT_TEXT_COLOR=$(getcolor zaitra_green)
export TEXT_COLOR=$(getcolor white)
export BAR_COLOR=$(getcolor trueblack 50)
# export BAR_COLOR=$(getcolor grey 50)
# export ITEM_BG_COLOR=$(getcolor blue)
export ITEM_BG_COLOR=$(getcolor zaitra_green)
export GROUP_BG_COLOR=$(getcolor zaitra_green 30)
export ACCENT_COLOR=$(getcolor trueblack)
export HIGHLIGHT=$(getcolor red)

# -- Teal Scheme --
# export BAR_COLOR=0xff001f30
# export ITEM_BG_COLOR=0xff003547
# export ACCENT_COLOR=0xff2cf9ed

# -- Gray Scheme --
# export BAR_COLOR=0xff101314
# export ITEM_BG_COLOR=0xff353c3f
# export ACCENT_COLOR=0xffffffff

# -- Purple Scheme --
# export BAR_COLOR=0xff140c42
# export ITEM_BG_COLOR=0xff2b1c84
# export ACCENT_COLOR=0xffeb46f9

# -- Red Scheme ---
# export BAR_COLOR=0xff23090e
# export ITEM_BG_COLOR=0xff591221
# export ACCENT_COLOR=0xffff2453

# -- Blue Scheme ---
# export BAR_COLOR=0xff021254
# export ITEM_BG_COLOR=0xff093aa8
# export ACCENT_COLOR=0xff15bdf9

# -- Green Scheme --
# export BAR_COLOR=0xff003315
# export ITEM_BG_COLOR=0xff008c39
# export ACCENT_COLOR=0xff1dfca1


# -- Orange Scheme --
# export BAR_COLOR=0xff381c02
# export ITEM_BG_COLOR=0xff99440a
# export ACCENT_COLOR=0xfff97716

# -- Yellow Scheme --
# export BAR_COLOR=0xff2d2b02
# export ITEM_BG_COLOR=0xff8e7e0a
# export ACCENT_COLOR=0xfff7fc17
