#!/bin/bash

battery=(
  icon.font="$FONT:Regular:18.0"
  label.drawing=off
  padding_left=0
  padding_right=5
  script="$PLUGIN_DIR/battery.sh"
  update_freq=120
  updates=on
)

sketchybar --add item battery right      \
           --set battery "${battery[@]}" \
           --subscribe battery power_source_change system_woke
