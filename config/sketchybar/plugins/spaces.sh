#!/bin/bash
# one aerospace query, then one sketchybar call for all workspaces:
# focused = accent pill, occupied = normal, empty = hidden
source "$CONFIG_DIR/globalstyles.sh"
source "$CONFIG_DIR/icon_map.sh"

FOCUSED="${FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null)}"
WINDOWS="$(aerospace list-windows --all --format '%{workspace}|%{app-name}' 2>/dev/null)"
args=()
for sid in 1 2 3 4 5 6 7 8 9 10; do
  icons=""
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    __icon_map "$app"
    icons+="$icon_result"
  done < <(printf '%s\n' "$WINDOWS" | awk -F'|' -v s="$sid" '$1==s {print $2}' | sort -u)

  if [ "$sid" = "$FOCUSED" ]; then
    args+=(--set space.$sid drawing=on label="$icons" label.drawing=$([ -n "$icons" ] && echo on || echo off)
           background.drawing=on background.color=$HIGHLIGHT icon.color=$NEGATIVE label.color=$NEGATIVE)
  elif [ -n "$icons" ]; then
    args+=(--set space.$sid drawing=on label="$icons" label.drawing=on
           background.drawing=off icon.color=$ICON_COLOR label.color=$ICON_COLOR)
  else
    args+=(--set space.$sid drawing=off)
  fi
done
sketchybar --animate tanh 15 "${args[@]}"
