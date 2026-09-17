#!/bin/bash
# open-meteo, no API key; coordinates are the cafeos ones (variables.nix)
sketchybar --add item weather right \
  --set weather icon.padding_left=$PADDINGS label.padding_right=$PADDINGS icon.color=$HIGHLIGHT \
    update_freq=1800 updates=on script="$PLUGIN_DIR/weather.sh" click_script="open -a Weather" \
  --subscribe weather system_woke wifi_change
