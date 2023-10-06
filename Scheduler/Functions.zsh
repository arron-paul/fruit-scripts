#!/usr/bin/env zsh

function show_dialog {

  # Show modal dialog on the user session
  local app_name="$1"
  local dialog_text="$2"
  local icon="$3"
  /usr/bin/osascript -e "
    tell application \"$app_name\"
      activate
      display dialog \"$dialog_text\" with icon $icon
    end tell
  "

}

function show_notification {

  # Show notification toast on the user session
  local message="$1"
  local title="$2"
  /usr/bin/osascript -e "display notification \"$message\" with title \"$title\""

}

function log_to_console {

  # Write a log message to Console.app
  local message="$1"
  /usr/bin/logger "Fruit Script: $1"

}
