#!/bin/bash
source "$CONFIG_DIR/colors.sh"
source "$CONFIG_DIR/icons.sh"

PADDINGS=6
FONT="JetBrainsMono Nerd Font"
APP_FONT="sketchybar-app-font"

# transparent bar inside the 32pt notch band; the brackets carry the background
bar=(
  color=$TRANSPARENT position=top topmost=off sticky=on height=32
  padding_left=4 padding_right=4 corner_radius=0 notch_width=200
)

item_defaults=(
  background.corner_radius=4 background.height=20
  background.padding_left=$((PADDINGS / 2)) background.padding_right=$((PADDINGS / 2))
  icon.color=$ICON_COLOR icon.font="$FONT:Semibold:12" icon.padding_left=0 icon.padding_right=0
  label.color=$LABEL_COLOR label.font="$FONT:Semibold:11"
  label.padding_left=$((PADDINGS / 2)) label.padding_right=0
  updates=when_shown
)

bracket_defaults=(background.corner_radius=6 background.height=24 background.color=$BAR_COLOR)
