#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Random: Unsplash
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Width", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Height", "optional": true }
# @raycast.packageName Custom

# Documentation:
# @raycast.description Generate URL to a random Unsplash image
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

WIDTH=$1
HEIGHT=$2

URL="https://source.unsplash.com/random"

if [[ "$WIDTH" != "" ]]; then
	URL="${URL}/${WIDTH}"

	if [[ "$HEIGHT" != "" ]]; then
		URL="${URL}x${HEIGHT}"
	else
		URL="${URL}x${WIDTH}"
	fi
fi

open "$URL"
