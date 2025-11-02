#!/usr/bin/env bash
set -euo pipefail

# Detect dockutil
DOCKUTIL="$(command -v dockutil || true)"
if [[ -z "${DOCKUTIL}" ]]; then
  echo "dockutil not found. Install with: brew install dockutil"
  exit 1
fi

# Helper: add app if it exists
add_app() {
  local app_path="$1"
  if [[ -e "$app_path" ]]; then
    "$DOCKUTIL" --no-restart --add "$app_path"
  else
    echo "Skipping (not found): $app_path"
  fi
}

# Reset Dock
"$DOCKUTIL" --no-restart --remove all

# --- Apps in order (from your screenshot) ---
# System apps
add_app "/Applications/Arc.app"
add_app "/Applications/Music.app"
add_app "/Applications/Messages.app"

# Utilities & work
add_app "/Applications/Drafts.app"
add_app "/Applications/Slack.app"
add_app "/Applications/Microsoft Outlook.app"
add_app "/Applications/Microsoft Excel.app"
add_app "/Applications/Microsoft PowerPoint.app"
add_app "/Applications/Calendar.app"
add_app "/Applications/Reminders.app"

# AI & productivity
add_app "/Applications/ChatGPT.app"

# Dev / editors
add_app "/Applications/NotePlan.app"
add_app "/Applications/Visual Studio Code.app"

# Communication
add_app "/Applications/Mail.app"
add_app "/Applications/zoom.app" # Zoom can be named differently depending on install

# Terminal & drawing
add_app "/Applications/Ghostty.app"

# AI & productivity
add_app "/Applications/Perplexity.app"

# --- Optional stacks on the right side ---
# Add Downloads stack (grid view, sort by date added)
"$DOCKUTIL" --no-restart --add '~/Library/Mobile Documents/com~apple~CloudDocs/Screenshots' --view grid --display folder --sort dateadded

# Add Documents stack (fan view)
"$DOCKUTIL" --no-restart --add '~/Downloads' --view fan --display folder

# Restart Dock to apply
killall Dock || true
