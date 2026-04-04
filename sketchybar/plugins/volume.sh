#!/bin/sh

MUTED=$(osascript -e 'output muted of (get volume settings)')

if [ "$MUTED" = "true" ]; then
  sketchybar --set $NAME icon="󰖁" label="mute"
  exit 0
fi

if [ "$SENDER" = "volume_change" ]; then
  VOLUME=$INFO
else
  VOLUME=$(osascript -e 'output volume of (get volume settings)')
fi

case $VOLUME in
[6-9][0-9] | 100)
  ICON="󰕾"
  ;;
[3-5][0-9])
  ICON="󰖀"
  ;;
[1-9] | [1-2][0-9])
  ICON="󰕿"
  ;;
*) ICON="󰖁" ;;
esac

sketchybar --set $NAME icon="$ICON" label="$VOLUME%"
