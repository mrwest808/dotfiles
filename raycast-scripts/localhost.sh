#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Localhost
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Port", "optional": true }
# @raycast.packageName Custom

# Documentation:
# @raycast.description Open localhost on given port
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

PORT=$1

if [ "$PORT" = "" ]; then
  PORT="3000"
fi

open "http://localhost:$PORT"
