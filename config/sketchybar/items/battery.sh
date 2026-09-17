#!/bin/bash
# percentage label only when low or charging, like Pe8er; click opens the native popover
sketchybar --add item battery right \
  --set battery icon.padding_left=$PADDINGS icon.padding_right=2 label.padding_right=$PADDINGS \
    update_freq=60 updates=on script="$PLUGIN_DIR/battery.sh" \
    click_script="$PLUGIN_DIR/menuextra_click.sh ControlCenter Battery x-apple.systempreferences:com.apple.Battery-Settings.extension" \
  --subscribe battery power_source_change system_woke
