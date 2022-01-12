#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Raindrop.io
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/raindrop-logo.png

# Documentation:
# @raycast.description Open raindrop.io in Safari
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

set theUrl to "https://app.raindrop.io"
set theUrlPattern to "app.raindrop.io"

openInSafari(theUrl, theUrlPattern)

on openInSafari(theUrl, theUrlPattern)
  tell application "Safari"
    set found to false
    set targetWindow to null
    set targetTabIndex to -1

    repeat with theWindow in every window
      set theTabIndex to 1
      repeat with theTab in (tabs of theWindow)
        if URL of theTab contains theUrlPattern
          set targetWindow to theWindow
          set targetTabIndex to theTabIndex
          set found to true
          exit repeat
        end if

        set theTabIndex to theTabIndex + 1
      end repeat

      if found then
        exit repeat
      end if
    end repeat

    if found then
      tell targetWindow
        set current tab to tab targetTabIndex
        activate
      end tell

      return
    end if

    tell front window
      if URL of current tab contains "favorites://" then
        set current tab's URL to theUrl
        set isEmptyTab to true
      else
        set current tab to (make new tab at end of tabs with properties {URL:theUrl})
      end if

      activate
    end tell
  end tell
end openInSafari

