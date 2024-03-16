#!/bin/sh

STATUS=$(defaults read com.apple.controlcenter "NSStatusItem Visible FocusModes")

if [ "$STATUS" -eq 0 ]; then
	sketchybar -m --set $NAME icon=""
else
	sketchybar -m --set $NAME icon=
fi
