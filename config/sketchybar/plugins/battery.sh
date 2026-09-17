#!/bin/bash
source "$CONFIG_DIR/globalstyles.sh"
BATT="$(pmset -g batt)"
PCT=$(echo "$BATT" | grep -Eo '[0-9]+%' | head -1 | tr -d %)
[ -z "$PCT" ] && exit 0
IDX=$(( (PCT + 5) / 10 )); [ $IDX -gt 10 ] && IDX=10
COLOR=$ICON_COLOR LABEL=off
if echo "$BATT" | grep -q 'AC Power'; then
  ICON=${ICONS_BATTERY_CHARGING[$IDX]} COLOR=$(getcolor green) LABEL=on
else
  ICON=${ICONS_BATTERY[$IDX]}
  if [ "$PCT" -le 10 ]; then COLOR=$(getcolor red) LABEL=on
  elif [ "$PCT" -le 20 ]; then COLOR=$(getcolor yellow) LABEL=on; fi
fi
sketchybar --set "$NAME" icon="$ICON" icon.color=$COLOR label="${PCT}%" label.drawing=$LABEL
