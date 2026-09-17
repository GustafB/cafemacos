#!/bin/bash
# focused window title, in the left pill after the workspaces
sketchybar --add item front_app left \
  --set front_app icon.drawing=off label.max_chars=50 scroll_texts=on \
    label.padding_left=$PADDINGS label.padding_right=$PADDINGS \
    script="$PLUGIN_DIR/front_app.sh" \
  --subscribe front_app front_app_switched aerospace_workspace_change
