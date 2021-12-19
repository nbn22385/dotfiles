#!/usr/bin/env bash

data=$(curl -s 'wttr.in/Orlando?format=%C+|+%t')
condition=$(echo $data | awk -F '|' '{print $1}' | tr '[:upper:]' '[:lower:]')
condition="${condition// /}"
temp=$(echo $data | awk -F '|' '{print $2}')
temp="${temp//\+/}"
temp="${temp// /}"

# add more conditions here as appropriate
case "${condition}" in
  "clear")
    icon=""
    ;;
  "sunny")
    icon=""
    ;;
  "partlycloudy")
    icon=""
    ;;
  "lightrain")
    icon=""
    ;;
  *)
    icon="$condition"
    ;;
esac

sketchybar -m --set weather icon="$icon" \
  --set weather label="$temp"
