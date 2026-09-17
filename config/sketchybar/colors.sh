#!/bin/bash
# Tokyo Night Storm, shared with borders and ghostty. getcolor <name> [opacity%]
PALETTE=(
  blue "#7aa2f7" cyan "#7dcfff" teal "#1abc9c" green "#9ece6a" yellow "#e0af68"
  orange "#ff9e64" red "#f7768e" purple "#bb9af7" grey "#565f89"
  black "#1a1b26" surface "#24283b" white "#c0caf5"
)
getcolor() {
  local name=$1 pct=${2:-100} hex=""
  for ((i = 0; i < ${#PALETTE[@]}; i += 2)); do
    [[ ${PALETTE[i]} == "$name" ]] && hex=${PALETTE[i+1]} && break
  done
  printf '0x%02X%s\n' $((pct * 255 / 100)) "${hex:1}"
}
BAR_COLOR=$(getcolor black 90)
TRANSPARENT=$(getcolor black 0)
HIGHLIGHT=$(getcolor blue)
ICON_COLOR=$(getcolor white)
LABEL_COLOR=$(getcolor white 75)
DIM=$(getcolor grey)
NEGATIVE=$(getcolor black)
