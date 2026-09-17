#!/bin/bash
K="$HOME/cafemac/bin/kbswitch"
case "$("$K" --current)" in
  Swedish*) "$K" U.S. ;;
  *) "$K" Swedish ;;
esac
NAME=keyboard "$CONFIG_DIR/plugins/keyboard.sh"
