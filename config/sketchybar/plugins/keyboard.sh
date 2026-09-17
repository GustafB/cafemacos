#!/bin/bash
case "$("$HOME/cafemac/bin/kbswitch" --current 2>/dev/null)" in
  U.S.|ABC) LABEL="US" ;;
  Swedish*) LABEL="SE" ;;
  *) LABEL="?" ;;
esac
sketchybar --set "$NAME" label="$LABEL"
