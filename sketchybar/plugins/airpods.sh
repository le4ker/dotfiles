#!/bin/sh

# Get AirPods battery information using system_profiler
get_airpods_battery() {
    # Try to get AirPods battery info from system_profiler
    AIRPODS_INFO=$(system_profiler SPBluetoothDataType 2>/dev/null | grep -A 20 -i "airpods\|headphones")
    
    if [ -z "$AIRPODS_INFO" ]; then
        # Fallback: try ioreg for Bluetooth battery info
        BATTERY_INFO=$(ioreg -r -k "BatteryPercent" | grep -i -A 5 -B 5 "airpods\|headphones" 2>/dev/null)
        if [ -n "$BATTERY_INFO" ]; then
            # Extract battery percentage from ioreg output
            LEFT_BATTERY=$(echo "$BATTERY_INFO" | grep -o '"BatteryPercentLeft" = [0-9]*' | head -1 | grep -o '[0-9]*')
            RIGHT_BATTERY=$(echo "$BATTERY_INFO" | grep -o '"BatteryPercentRight" = [0-9]*' | head -1 | grep -o '[0-9]*')
            CASE_BATTERY=$(echo "$BATTERY_INFO" | grep -o '"BatteryPercentCase" = [0-9]*' | head -1 | grep -o '[0-9]*')
        fi
    else
        # Extract battery from system_profiler output
        LEFT_BATTERY=$(echo "$AIRPODS_INFO" | grep -i "left" | grep -o '[0-9]*%' | head -1 | tr -d '%')
        RIGHT_BATTERY=$(echo "$AIRPODS_INFO" | grep -i "right" | grep -o '[0-9]*%' | head -1 | tr -d '%')
        CASE_BATTERY=$(echo "$AIRPODS_INFO" | grep -i "case" | grep -o '[0-9]*%' | head -1 | tr -d '%')
    fi
    
    # Alternative method using defaults and parsing plist data
    if [ -z "$LEFT_BATTERY" ] && [ -z "$RIGHT_BATTERY" ]; then
        # Try to get battery info from Bluetooth preferences
        BT_PLIST="$HOME/Library/Preferences/com.apple.Bluetooth.plist"
        if [ -f "$BT_PLIST" ]; then
            # This is a more complex parsing that might work for some systems
            DEVICE_INFO=$(defaults read com.apple.Bluetooth 2>/dev/null | grep -A 10 -B 2 -i "airpods\|headphones" || true)
            if [ -n "$DEVICE_INFO" ]; then
                LEFT_BATTERY=$(echo "$DEVICE_INFO" | grep -i "left" | grep -o '[0-9]*' | head -1)
                RIGHT_BATTERY=$(echo "$DEVICE_INFO" | grep -i "right" | grep -o '[0-9]*' | head -1)
                CASE_BATTERY=$(echo "$DEVICE_INFO" | grep -i "case" | grep -o '[0-9]*' | head -1)
            fi
        fi
    fi
}

# Get the battery info
get_airpods_battery

# Default values if no AirPods detected
ICON="󰋋"
LABEL="N/A"

# Check if we have any battery information
if [ -n "$LEFT_BATTERY" ] || [ -n "$RIGHT_BATTERY" ] || [ -n "$CASE_BATTERY" ]; then
    # AirPods are connected, show battery info
    ICON="󰋋"  # AirPods icon
    
    # Build the label based on available battery info
    LABEL=""
    
    if [ -n "$LEFT_BATTERY" ] && [ -n "$RIGHT_BATTERY" ]; then
        # Both earbuds detected
        if [ -n "$CASE_BATTERY" ]; then
            LABEL="L:${LEFT_BATTERY}% R:${RIGHT_BATTERY}% C:${CASE_BATTERY}%"
        else
            LABEL="L:${LEFT_BATTERY}% R:${RIGHT_BATTERY}%"
        fi
    elif [ -n "$LEFT_BATTERY" ]; then
        # Only left earbud
        LABEL="L:${LEFT_BATTERY}%"
        if [ -n "$CASE_BATTERY" ]; then
            LABEL="${LABEL} C:${CASE_BATTERY}%"
        fi
    elif [ -n "$RIGHT_BATTERY" ]; then
        # Only right earbud
        LABEL="R:${RIGHT_BATTERY}%"
        if [ -n "$CASE_BATTERY" ]; then
            LABEL="${LABEL} C:${CASE_BATTERY}%"
        fi
    elif [ -n "$CASE_BATTERY" ]; then
        # Only case battery
        LABEL="C:${CASE_BATTERY}%"
    fi
    
    # Change icon color based on lowest battery level
    LOWEST_BATTERY=""
    if [ -n "$LEFT_BATTERY" ] && [ -n "$RIGHT_BATTERY" ]; then
        if [ "$LEFT_BATTERY" -lt "$RIGHT_BATTERY" ]; then
            LOWEST_BATTERY=$LEFT_BATTERY
        else
            LOWEST_BATTERY=$RIGHT_BATTERY
        fi
    elif [ -n "$LEFT_BATTERY" ]; then
        LOWEST_BATTERY=$LEFT_BATTERY
    elif [ -n "$RIGHT_BATTERY" ]; then
        LOWEST_BATTERY=$RIGHT_BATTERY
    fi
    
    # Set icon based on battery level (if we have earbud battery info)
    if [ -n "$LOWEST_BATTERY" ]; then
        if [ "$LOWEST_BATTERY" -le 20 ]; then
            ICON="󰤾"  # Low battery AirPods
        elif [ "$LOWEST_BATTERY" -le 50 ]; then
            ICON="󰤿"  # Medium battery AirPods
        else
            ICON="󰋋"  # Full battery AirPods
        fi
    fi
else
    # No AirPods detected or not connected
    ICON="󰋍"  # Disconnected AirPods icon
    LABEL="Not Connected"
fi

# Update sketchybar
# $NAME is set by sketchybar when the script is called as a plugin
# For testing purposes, use 'airpods' as fallback
ITEM_NAME=${NAME:-airpods}
sketchybar --set "$ITEM_NAME" icon="$ICON" label="$LABEL"
