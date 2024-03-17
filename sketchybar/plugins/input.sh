#!/usr/bin/env sh

SOURCE=$(defaults read ~/Library/Preferences/com.apple.HIToolbox.plist AppleCurrentKeyboardLayoutInputSourceID)

case ${SOURCE} in
'com.apple.keylayout.ABC') ICON='' && LABEL='US' ;;
'com.apple.keylayout.Greek') ICON='󱌮' && LABEL='GR' ;;
esac

sketchybar --set $NAME icon="$ICON" label="$LABEL"
