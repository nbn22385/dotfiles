#!/usr/bin/env bash

RUNNING=$(osascript -e 'if application "Mail" is running then return 0')
COUNT=0

if [ $RUNNING == 0 ]; then
  COUNT=$(osascript -e 'tell application "Mail" to return the unread count of inbox')
  if [ $COUNT != "0" ]; then
    sketchybar -m --set $NAME label="$COUNT" icon=
  else
    sketchybar -m --set $NAME label="" icon=
  fi
else
  sketchybar -m --set $NAME label="" icon=
fi

