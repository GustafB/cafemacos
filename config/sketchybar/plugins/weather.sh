#!/bin/bash
source "$CONFIG_DIR/globalstyles.sh"
LAT=59.3 LON=18.1
DATA=$(curl -fsS -m 8 "https://api.open-meteo.com/v1/forecast?latitude=$LAT&longitude=$LON&current=temperature_2m,weather_code,is_day")
if [ -z "$DATA" ]; then
  sketchybar --set "$NAME" icon=$ICON_WEATHER_FALLBACK label.drawing=off
  exit 0
fi
read -r TEMP CODE DAY < <(echo "$DATA" | jq -r '.current | "\(.temperature_2m|round) \(.weather_code) \(.is_day)"')
# WMO weather codes
case $CODE in
  0) ICON=$([ "$DAY" = 1 ] && echo 󰖙 || echo 󰖔) ;;
  1|2) ICON=$([ "$DAY" = 1 ] && echo 󰖕 || echo 󰼱) ;;
  3) ICON=󰖐 ;;
  45|48) ICON=󰖑 ;;
  5[1-7]|6[1-7]) ICON=󰖗 ;;
  7[1-7]|8[5-6]) ICON=󰖘 ;;
  8[0-2]) ICON=󰖖 ;;
  9[5-9]) ICON=󰖓 ;;
  *) ICON=$ICON_WEATHER_FALLBACK ;;
esac
sketchybar --set "$NAME" icon="$ICON" label="${TEMP}°" label.drawing=on
