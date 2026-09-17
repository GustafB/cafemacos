#!/bin/bash
# number + app icons per workspace; one hidden updater item refreshes all ten in a single call
for sid in 1 2 3 4 5 6 7 8 9 10; do
  sketchybar --add item space.$sid left \
    --set space.$sid icon="$sid" icon.padding_left=$PADDINGS icon.padding_right=2 \
      label.font="$APP_FONT:Regular:14" label.padding_left=2 label.padding_right=$PADDINGS \
      label.y_offset=-1 background.height=18 drawing=off \
      click_script="aerospace workspace $sid"
done
sketchybar --add item spaces_updater left \
  --set spaces_updater drawing=off updates=on update_freq=10 script="$PLUGIN_DIR/spaces.sh" \
  --subscribe spaces_updater aerospace_workspace_change front_app_switched
