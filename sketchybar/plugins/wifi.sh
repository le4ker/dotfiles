#!/bin/sh

# Get WiFi interface (usually en0 on macOS)
WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}')
: "${WIFI_INTERFACE:=en0}"

# Check if WiFi is on
WIFI_STATUS=$(networksetup -getairportpower "$WIFI_INTERFACE" 2>/dev/null | awk '{print $4}')

if [ "$WIFI_STATUS" = "Off" ] || [ -z "$WIFI_STATUS" ]; then
  sketchybar --set "$NAME" icon="󰤭" label=""
  exit 0
fi

# Get SSID via networksetup
SSID=$(networksetup -getairportnetwork "$WIFI_INTERFACE" 2>/dev/null | sed 's/Current Wi-Fi Network: //')

if [ -z "$SSID" ] || echo "$SSID" | grep -qiE "(not associated|error|cannot|You are not)"; then
  sketchybar --set "$NAME" icon="󰤨" label=""
  exit 0
fi

sketchybar --set "$NAME" icon="󰤨" label=""
