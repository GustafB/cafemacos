#!/bin/bash
# apple logo, like Pe8er's: click toggles tiles/accordion,
# lights up while AeroSpace is in resize mode
sketchybar --add item mode left \
  --set mode icon=$ICON_APPLE icon.font="Helvetica:Bold:14" icon.padding_left=$PADDINGS icon.padding_right=$PADDINGS \
    script="$PLUGIN_DIR/mode.sh" click_script="aerospace layout tiles accordion" \
  --subscribe mode aerospace_mode_change
