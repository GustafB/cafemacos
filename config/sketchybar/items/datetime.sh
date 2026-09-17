#!/bin/bash
# tiny date stacked above the clock (Pe8er's width=0 trick)
sketchybar --add item date right \
  --set date icon.drawing=off label.font="$FONT:Semibold:7" label.padding_left=$PADDINGS \
    label.padding_right=4 y_offset=6 width=0 update_freq=60 \
    script='sketchybar --set $NAME label="$(date "+%a %d %b")"' click_script="open -a Calendar" \
  --add item clock right \
  --set clock icon.drawing=off label.font="$FONT:Bold:10" label.padding_left=$PADDINGS \
    label.padding_right=4 y_offset=-3 update_freq=10 \
    script='sketchybar --set $NAME label="$(date "+%H:%M")"' click_script="open -a Calendar"
