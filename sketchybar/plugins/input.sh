#!/usr/bin/env sh

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.ABC') LABEL='US' ;;
'com.apple.keylayout.Greek') LABEL='GR' ;;
esac

sketchybar --set $NAME label="$LABEL"
