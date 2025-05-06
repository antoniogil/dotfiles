#!/bin/bash

theme="kMenu"
dir="$HOME/.config/rofi"
rofi_command="rofi -theme $dir/$theme -no-fixed-num-lines"

onlyPrimary="primary"
onlyExternal="external"
both="both"

confirm_exit() {
  confirm=$(printf "No\nYes" | $rofi_command -dmenu -i -lines 2 -p "Are You Sure?")

  [[ "$confirm" == "Yes" ]]
}

options="$onlyPrimary\n$onlyExternal\n$both"

chosen="$(echo -e "$options" | $rofi_command -p -dmenu -lines 4 -selected-row 2)"
case $chosen in
$onlyPrimary)
  if confirm_exit; then
    hyprctl keyword monitor eDP-1, 1920x1080, 0x0, 1
    hyprctl keyword monitor HDMI-A-1, disabled
  fi
  ;;
$onlyExternal)
  if confirm_exit; then
    hyprctl keyword monitor eDP-1, disabled
    hyprctl keyword monitor HDMI-A-1, 2560x1080, 0x0, 1
  fi
  ;;
$both)
  if confirm_exit; then
    hyprctl keyword monitor eDP-1, 1920x1080, 0x0, 1
    hyprctl keyword monitor HDMI-A-1, 2560x1080, 1920x0, 1
  fi
  ;;

esac
