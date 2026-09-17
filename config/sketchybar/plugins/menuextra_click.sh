#!/bin/bash
# Alias items only mirror the native extra; open the real popover through System Events
# (needs Accessibility for sketchybar). Falls back to the settings pane and logs why.
#   menuextra_click.sh <process> <menu bar item description substring> <settings url>
PROC="$1" MATCH="$2" FALLBACK="$3"
LOG="/tmp/sketchybar-menuextra.log"
ERR=$(osascript 2>&1 >/dev/null <<APPLESCRIPT
tell application "System Events" to tell process "$PROC"
  click (first menu bar item of menu bar 1 whose description contains "$MATCH")
end tell
APPLESCRIPT
)
if [ -n "$ERR" ]; then
  echo "$(date '+%H:%M:%S') $PROC/$MATCH: $ERR" >> "$LOG"
  open "$FALLBACK"
fi
