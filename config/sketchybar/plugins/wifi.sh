#!/bin/bash
source "$CONFIG_DIR/globalstyles.sh"
if [ "$(networksetup -getairportpower en0 2>/dev/null | awk '{print $NF}')" = "Off" ]; then
  ICON=$ICON_WIFI_OFF COLOR=$DIM
elif [ -n "$(ipconfig getifaddr en0 2>/dev/null)" ]; then
  ICON=$ICON_WIFI COLOR=$ICON_COLOR
else
  ICON=$ICON_WIFI_DISCONNECTED COLOR=$DIM
fi
sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR
