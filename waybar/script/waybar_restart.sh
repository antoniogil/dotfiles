#!/bin/bash

if pgrep -x "waybar" >/dev/null; then
  killall waybar
fi

waybar -c ~/.config/waybar/config_horizontal -s ~/.config/waybar/stylehor.css &
