#!/bin/bash
source "$CONFIG_DIR/globalstyles.sh"
if [ "$1" = "toggle" ]; then
  osascript -e 'set volume output muted (not (output muted of (get volume settings)))'
fi
if [ "$SENDER" = "volume_change" ]; then
  VOLUME="$INFO"
else
  VOLUME="$(osascript -e 'output volume of (get volume settings)')"
fi
MUTED="$(osascript -e 'output muted of (get volume settings)')"
if [ "$MUTED" = "true" ] || [ "$VOLUME" -eq 0 ]; then ICON=${ICONS_VOLUME[0]}
elif [ "$VOLUME" -lt 34 ]; then ICON=${ICONS_VOLUME[1]}
elif [ "$VOLUME" -lt 67 ]; then ICON=${ICONS_VOLUME[2]}
else ICON=${ICONS_VOLUME[3]}; fi
sketchybar --set volume icon="$ICON" label="$VOLUME%"
