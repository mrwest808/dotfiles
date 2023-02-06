#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Hitta.se
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Number" }
# @raycast.packageName Custom

# Documentation:
# @raycast.description Lookup number on hitta.se
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

open "https://www.hitta.se/vem-ringde/$1"
