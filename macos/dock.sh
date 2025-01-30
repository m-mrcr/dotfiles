#!/bin/sh

dockutil --no-restart --remove all
dockutil --no-restart --add "/System/Applications/Anytype.app"
dockutil --no-restart --add "/System/Applications/Messages.app"
dockutil --no-restart --add "/System/Applications/Microsoft Excel.app"
dockutil --no-restart --add "/System/Applications/Microsoft Outlook.app"
dockutil --no-restart --add "/System/Applications/Obsidian.app"
dockutil --no-restart --add "/System/Applications/Slack.app"
dockutil --no-restart --add "/System/Applications/Utilities/Terminal.app"
dockutil --no-restart --add "/System/Applications/System Settings.app"
dockutil --no-restart --add "/Applications/Spotify.app"

killall Dock
