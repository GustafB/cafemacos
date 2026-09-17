#!/bin/bash
TITLE="$(aerospace list-windows --focused --format '%{window-title}' 2>/dev/null)"
[ -z "$TITLE" ] && TITLE="$INFO"
sketchybar --set "$NAME" label="$TITLE"
