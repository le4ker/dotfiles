#\!/bin/sh

STATUS=$(defaults read com.apple.controlcenter "NSStatusItem VisibleCC FocusModes" 2>/dev/null || echo "0")

if [ "$STATUS" = "1" ]; then
  sketchybar --set $NAME icon=""
else
  sketchybar --set $NAME icon=""
fi
