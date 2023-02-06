#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Splunk
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Since", "optional": true }
# @raycast.packageName Custom

# Documentation:
# @raycast.description Provide a search query that will be opened in Splunk
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

QUERY=$1
EARLIEST=$2

if [ "$EARLIEST" = "" ]; then
	EARLIEST="4h%40m"
fi

URL="https://splunk.sbab.se/en-US/app/Dev/search?q=$QUERY&earliest=-$EARLIEST&latest=now"

open "$URL"
