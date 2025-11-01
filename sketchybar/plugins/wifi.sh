#!/bin/sh

# Get WiFi interface (usually en0 or en1 on macOS)
WIFI_INTERFACE=$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}')

if [ -z "$WIFI_INTERFACE" ]; then
  WIFI_INTERFACE="en0"
fi

# Check if WiFi is on
WIFI_STATUS=$(networksetup -getairportpower "$WIFI_INTERFACE" 2>/dev/null | awk '{print $4}')

if [ "$WIFI_STATUS" = "Off" ] || [ -z "$WIFI_STATUS" ]; then
  sketchybar --set $NAME icon="󰤭" label=""
  exit 0
fi

# Method 1: Try system_profiler (most reliable for getting SSID)
SSID=$(system_profiler SPAirPortDataType 2>/dev/null | awk '/Current Network Information:/ {getline; if (NF > 0 && $NF != "Infrastructure:") {gsub(/:/, "", $1); print $1; exit}}')

# Method 2: Try networksetup if system_profiler didn't work
if [ -z "$SSID" ] || [ "$SSID" = "" ]; then
  WIFI_RESPONSE=$(networksetup -getairportnetwork "$WIFI_INTERFACE" 2>/dev/null)
  # Check if response contains an error message (case-insensitive)
  if echo "$WIFI_RESPONSE" | grep -qiE "(not associated|error|cannot|You are not)"; then
    SSID=""
  else
    # Extract SSID from response (remove "Current Wi-Fi Network: " prefix)
    SSID=$(echo "$WIFI_RESPONSE" | sed 's/Current Wi-Fi Network: //' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
    # Verify it's not an error message
    if echo "$SSID" | grep -qiE "(not associated|error|cannot|You are not)"; then
      SSID=""
    fi
  fi
fi

# Method 3: Try airport command as last resort
if [ -z "$SSID" ] || [ "$SSID" = "" ]; then
  AIRPORT="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  if [ -f "$AIRPORT" ]; then
    WIFI_INFO=$("$AIRPORT" -I 2>/dev/null 2>&1 | grep -v "WARNING\|deprecated")
    if [ ! -z "$WIFI_INFO" ]; then
      SSID=$(echo "$WIFI_INFO" | awk '/ SSID:/ {for(i=2;i<=NF;i++) printf "%s%s", (i>2?" ":""), $i; print ""}' | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')
      SIGNAL=$(echo "$WIFI_INFO" | awk '/ agrCtlRSSI:/ {print $2}')
    fi
  fi
fi

# Clean up SSID (remove any remaining whitespace/newlines)
SSID=$(echo "$SSID" | sed 's/^[[:space:]]*//' | sed 's/[[:space:]]*$//')

# Check if we still don't have a valid SSID
if [ -z "$SSID" ] || [ "$SSID" = "" ] || echo "$SSID" | grep -qiE "(not associated|error|cannot|You are not)"; then
  sketchybar --set $NAME icon="󰤨" label=""
  exit 0
fi

# Get signal strength if not already obtained
if [ -z "$SIGNAL" ]; then
  AIRPORT="/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport"
  if [ -f "$AIRPORT" ]; then
    WIFI_INFO=$("$AIRPORT" -I 2>/dev/null 2>&1 | grep -v "WARNING\|deprecated")
    SIGNAL=$(echo "$WIFI_INFO" | awk '/ agrCtlRSSI:/ {print $2}')
  fi
fi

# Convert RSSI to percentage (RSSI ranges from -100 to -50 typically)
# -50 is excellent, -100 is very poor
if [ ! -z "$SIGNAL" ] && [ "$SIGNAL" != "" ]; then
  RSSI=$SIGNAL
  if [ $RSSI -ge -50 ]; then
    PERCENTAGE=100
  elif [ $RSSI -ge -60 ]; then
    PERCENTAGE=80
  elif [ $RSSI -ge -70 ]; then
    PERCENTAGE=60
  elif [ $RSSI -ge -80 ]; then
    PERCENTAGE=40
  elif [ $RSSI -ge -90 ]; then
    PERCENTAGE=20
  else
    PERCENTAGE=0
  fi
else
  # Default to good signal if we can't measure it
  PERCENTAGE=80
fi

# Set icon based on signal strength
case $PERCENTAGE in
  100 | 80)
    ICON="󰤨"
    ;;
  60)
    ICON="󰤥"
    ;;
  40)
    ICON="󰤢"
    ;;
  20)
    ICON="󰤟"
    ;;
  *)
    ICON="󰤯"
    ;;
esac

sketchybar --set $NAME icon="$ICON" label=""
