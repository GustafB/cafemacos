#!/bin/bash
# US/SE indicator; click toggles through bin/kbswitch, no permissions needed
sketchybar --add item keyboard right \
  --set keyboard icon=$ICON_KEYBOARD icon.padding_left=$PADDINGS label.padding_right=$PADDINGS \
    update_freq=2 updates=on script="$PLUGIN_DIR/keyboard.sh" click_script="$PLUGIN_DIR/keyboard_toggle.sh"
