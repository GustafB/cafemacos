#!/bin/bash
# state icon only: macOS 15 redacts the SSID without Location Services. Click opens the
# native Wi-Fi popover via System Events (Accessibility), settings pane as fallback.
sketchybar --add item wifi right \
  --set wifi icon=$ICON_WIFI icon.padding_left=$PADDINGS icon.padding_right=$PADDINGS label.drawing=off \
    update_freq=5 updates=on script="$PLUGIN_DIR/wifi.sh" \
    click_script="$PLUGIN_DIR/menuextra_click.sh ControlCenter Wi x-apple.systempreferences:com.apple.wifi-settings-extension" \
  --subscribe wifi wifi_change system_woke
