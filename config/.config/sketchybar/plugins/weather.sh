#!/usr/bin/env bash

data=$(curl -s 'wttr.in/Orlando?format=%C+|+%t')

if [[ "$data" == *"nknown"* ]]; then
  exit
fi

condition=$(echo $data | awk -F '|' '{print $1}' | tr '[:upper:]' '[:lower:]')
condition="${condition// /}"
temp=$(echo $data | awk -F '|' '{print $2}')
temp="${temp//\+/}"
temp="${temp// /}"

currenttime=$(date +%H:%M)
night=0
if [[ "$currenttime" > "20:00" ]] || [[ "$currenttime" < "06:00" ]]; then
  night=1
fi

# add more conditions here as appropriate
case "${condition}" in
  "clear")
    if [[ $night -eq 1 ]]; then
      icon="󰖔" # nf-md-weather_night
    else
      icon="󰖙" # nf-md-weather_sunny
    fi
    ;;
  "sunny")
    icon="󰖙" # nf-md-weather_sunny
    ;;
  "partlycloudy")
    if [[ $night -eq 1 ]]; then
      icon="󰖔" # nf-md-weather_night_partly_cloudy
    else
      icon="󰖕" # nf-md-weather_partly_cloudy
    fi
    ;;
  *"lightrain"*)
    icon="󰖖" # nf-md-weather_pouring
    ;;
  "overcast")
    icon="󰖐" # nf-md-weather_cloudy
    ;;
  *)
    icon="󰖙" # nf-md-weather_sunny
    ;;
esac

sketchybar --set $NAME icon="$icon" label="$temp"
