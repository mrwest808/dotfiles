#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Splunk: Latest Container
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Source(s)", "percentEncoded": true }
# @raycast.packageName Custom

# Documentation:
# @raycast.description Show latest container_image for given soure
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

INPUT=$1

QUERY="source%20IN%20($INPUT)%20%7C%20dedup%20source%20%7C%20table%20_time%20source%20container_image"
URL="https://splunk.sbab.se/en-US/app/Dev/search?q=$QUERY&earliest=-4h%40m&latest=now"

open "$URL"
