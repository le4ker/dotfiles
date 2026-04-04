#!/bin/sh

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)
case ${SOURCE} in
'com.apple.keylayout.US') ICON='' && LABEL='US' ;;
'com.apple.keylayout.Greek') ICON='󱌮' && LABEL='GR' ;;
*) ICON='󰌌' && LABEL='??' ;;
esac

sketchybar --set $NAME icon="$ICON" label="$LABEL"
