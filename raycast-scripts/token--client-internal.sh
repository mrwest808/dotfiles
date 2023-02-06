#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Token: CLIENT + INTERNAL
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Custom

# Documentation:
# @raycast.description Generate a mocked token with scope CLIENT + INTERNAL
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

URL="https://k8sproxy.acc.sbab.se/partner-auth-service/v1/mockauth/mockraw?scope=CLIENT,INTERNAL&rawscope=CLIENT,INTERNAL&client_id=teampartner&ttl=28800"
TOKEN=$(curl -s "$URL" | jq -r ".user_token")

echo -n "Bearer $TOKEN" | pbcopy
echo "Copied to clipboard"
