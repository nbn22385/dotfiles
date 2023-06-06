#!/usr/bin/env sh

POPUP_CLICK_SCRIPT="sketchybar --set \$NAME popup.drawing=toggle"

sketchybar --add alias  "Control Center,WiFi" right                      \
           --rename     "Control Center,WiFi" wifi_alias                 \
           --set        wifi_alias    icon.drawing=off                   \
                                      alias.color="$WHITE"               \
                                      background.padding_right=0         \
                                      icon.padding_right=0               \
                                      align=right                        \
                                      click_script="$POPUP_CLICK_SCRIPT" \
                                      update_freq=1                      \
                                      script="$PLUGIN_DIR/wifi.sh"       \
           --subscribe  wifi_alias    mouse.entered                      \
                                      mouse.exited                       \
                                      mouse.exited.global                \
                                                                         \
            --add       item          wifi.details popup.wifi_alias      \
            --set       wifi.details  background.corner_radius=12        \
                                      background.padding_left=7          \
                                      background.padding_right=7         \
                                      icon.background.height=2           \
                                      icon.background.y_offset=-12       \
                                      click_script="sketchybar --set wifi.alias popup.drawing=off"
