#!/usr/bin/env bash

weather=(
  icon.color=$WHITE
  icon.font="SFMono Nerd Font:Bold:16.0"
  padding_left=10
  script="$PLUGIN_DIR/weather.sh"
  update_freq=1800
)

sketchybar --add item weather right      \
           --set weather "${weather[@]}"
