#!/bin/sh

# Get AirPods battery info from system_profiler
AIRPODS_INFO=$(system_profiler SPBluetoothDataType 2>/dev/null | grep -A 20 -i "airpods\|headphones")

if [ -n "$AIRPODS_INFO" ]; then
  LEFT_BATTERY=$(echo "$AIRPODS_INFO" | grep -i "left" | grep -o '[0-9]*%' | head -1 | tr -d '%')
  RIGHT_BATTERY=$(echo "$AIRPODS_INFO" | grep -i "right" | grep -o '[0-9]*%' | head -1 | tr -d '%')
  CASE_BATTERY=$(echo "$AIRPODS_INFO" | grep -i "case" | grep -o '[0-9]*%' | head -1 | tr -d '%')
fi

if [ -z "$LEFT_BATTERY" ] && [ -z "$RIGHT_BATTERY" ] && [ -z "$CASE_BATTERY" ]; then
  sketchybar --set "$NAME" icon="󰋍" label="Not Connected"
  exit 0
fi

# Build label
LABEL=""
[ -n "$LEFT_BATTERY" ] && LABEL="L:${LEFT_BATTERY}%"
[ -n "$RIGHT_BATTERY" ] && LABEL="${LABEL:+$LABEL }R:${RIGHT_BATTERY}%"
[ -n "$CASE_BATTERY" ] && LABEL="${LABEL:+$LABEL }C:${CASE_BATTERY}%"

# Pick icon based on lowest earbud battery
LOWEST=""
if [ -n "$LEFT_BATTERY" ] && [ -n "$RIGHT_BATTERY" ]; then
  [ "$LEFT_BATTERY" -lt "$RIGHT_BATTERY" ] && LOWEST=$LEFT_BATTERY || LOWEST=$RIGHT_BATTERY
elif [ -n "$LEFT_BATTERY" ]; then
  LOWEST=$LEFT_BATTERY
elif [ -n "$RIGHT_BATTERY" ]; then
  LOWEST=$RIGHT_BATTERY
fi

ICON="󰋋"
if [ -n "$LOWEST" ]; then
  [ "$LOWEST" -le 20 ] && ICON="󰤾"
  [ "$LOWEST" -gt 20 ] && [ "$LOWEST" -le 50 ] && ICON="󰤿"
fi

sketchybar --set "$NAME" icon="$ICON" label="$LABEL"
