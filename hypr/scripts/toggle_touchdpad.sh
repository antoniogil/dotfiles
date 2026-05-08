#!/bin/bash
FILE="$HOME/.cache/touchpad_state"
# if [! -f "$FILE" ] || [ "$(cat "$FILE")" = "true"]; then
if [ ! -f "$FILE" ] || [ "$(cat "$FILE")" = "true" ]; then
  hyprctl keyword "device[synps/2-synaptics-touchpad]:enabled" false
  # hyprctl keyword "device[$device]:enabled" false
  echo "false" >"$FILE"
  notify-send "Touchpad" "Disabled"
else
  # hyprctl keyword "device[$device]:enabled" true
  hyprctl keyword "device[synps/2-synaptics-touchpad]:enabled" true
  echo "true" >"$FILE"
  notify-send "Touchpad" "Enabled"
fi
