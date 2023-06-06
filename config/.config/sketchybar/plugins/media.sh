#!/bin/bash

source "$CONFIG_DIR/colors.sh"

STATE="$(echo "$INFO" | jq -r '.state')"

if [ "$STATE" = "playing" ]; then
  MEDIA="$(echo "$INFO" | jq -r '"󰎈  " + .artist + " - " + .title')"
  sketchybar --set $NAME label="$MEDIA" drawing=on label.color=$WHITE
else
  # sketchybar --set $NAME drawing=off
  MEDIA="$(echo "$INFO" | jq -r '"󰎊  " + .artist + " - " + .title')"
  sketchybar --set $NAME label="$MEDIA" drawing=on label.color=$GREY
fi
