#!/usr/bin/env bash

mail=(
  icon=
  icon.color=$BLUE
  icon.font="SFMono Nerd Font:Bold:18.0"
  padding_right=5
  script="$PLUGIN_DIR/mail.sh"
  update_freq=30
  click_script="osascript -e 'tell application \"Mail\" to activate'"
)

sketchybar --add item mail right \
           --set mail "${mail[@]}"
