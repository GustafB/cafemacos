#!/bin/bash
source "$CONFIG_DIR/globalstyles.sh"
if [ "$MODE" = "resize" ]; then
  sketchybar --animate tanh 10 --set "$NAME" icon=$ICON_RESIZE icon.font="$FONT:Semibold:12" icon.color=$HIGHLIGHT
else
  sketchybar --animate tanh 10 --set "$NAME" icon=$ICON_APPLE icon.font="Helvetica:Bold:14" icon.color=$ICON_COLOR
fi
