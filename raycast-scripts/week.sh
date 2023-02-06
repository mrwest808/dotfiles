#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Week
# @raycast.mode inline
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.icon 📆
# @raycast.packageName Custom

# Documentation:
# @raycast.description What week number is it?
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

WEEK=$(date +"Week %U of %Y")

echo "${WEEK}"

