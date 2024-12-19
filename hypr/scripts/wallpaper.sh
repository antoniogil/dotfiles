filename=$(ls $HOME/Pictures/ | grep "" | rofi -dmenu -theme $HOME/.config/rofi/launchers/style.rasi)

wallpaper="$HOME/Pictures/$filename"

if ["$filename" = ""]; then
  exit
fi

echo $filename
echo $wallpaper

swww img $wallpaper -t random
