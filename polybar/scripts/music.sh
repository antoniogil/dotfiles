#!/bin/bash

mpd

if [ $? -eq 0 ]; then
  notify-send -u low "mpd started" &
else
  notify-send -u critical "Failed to start mpd" &
fi

st -e ncmpcpp &
st -e vis &

