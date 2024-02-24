#!/bin/sh

status=$(defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes")

if [ "$status" -eq 0 ]; then
	sketchybar -m --set $NAME icon=""
else
	sketchybar -m --set $NAME icon=
fi
