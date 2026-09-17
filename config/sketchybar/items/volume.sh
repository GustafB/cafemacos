#!/bin/bash
sketchybar --add item volume right \
  --set volume icon.padding_left=$PADDINGS label.padding_right=$PADDINGS \
    script="$PLUGIN_DIR/volume.sh" click_script="$PLUGIN_DIR/volume.sh toggle" \
  --subscribe volume volume_change
