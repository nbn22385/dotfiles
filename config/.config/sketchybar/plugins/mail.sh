#!/usr/bin/env bash

MAIL_RUNNING=$(osascript -e 'if application "Mail" is running then return 0')
UNREAD_COUNT=0

if [ $MAIL_RUNNING == 0 ]; then
  UNREAD_COUNT=$(osascript -e 'tell application "Mail" to return the unread count of inbox')
  if [ $UNREAD_COUNT != "0" ]; then
    sketchybar -m --set $NAME drawing=on label="$UNREAD_COUNT" icon=󰺻
  else
    sketchybar -m --set $NAME drawing=off
  fi
else
  sketchybar -m --set $NAME drawing=off
fi
