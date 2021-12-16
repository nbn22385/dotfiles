#!/bin/bash

APP_TITLE=$(yabai -m query --windows --window | jq -r '.app')
WINDOW_TITLE=$(yabai -m query --windows --window | jq -r '.title')

if [[ $APP_TITLE != "" ]]; then
  APP_TITLE="$APP_TITLE |"
fi

if [[ $WINDOW_TITLE = "" ]]; then
  WINDOW_TITLE=$APP_TITLE
fi

if [[ ${#WINDOW_TITLE} -gt 50 ]]; then
  WINDOW_TITLE=$(echo "$WINDOW_TITLE" | cut -c 1-50)
  sketchybar -m --set title label="$APP_TITLE $WINDOW_TITLE"…
  exit 0
fi

sketchybar -m --set title label="$APP_TITLE $WINDOW_TITLE"
