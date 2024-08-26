#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title NATO
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Letters" }
# @raycast.packageName Custom

# Documentation:
# @raycast.description Convert letters to NATO phonetic alphabet
# @raycast.author Johan West
# @raycast.authorURL johanwest.com

echo "Hello World! Argument1 value: "$1""

# Take first word of input string ($1)
word=$1

# Convert word to uppercase
word=$(echo $word | tr '[:lower:]' '[:upper:]')

# Initialize output string
output=""

# Loop through each character in the word
for ((i = 0; i < ${#word}; i++)); do
  char="${word:$i:1}"
  case $char in
  A) output+="Alpha " ;;
  B) output+="Bravo " ;;
  C) output+="Charlie " ;;
  D) output+="Delta " ;;
  E) output+="Echo " ;;
  F) output+="Foxtrot " ;;
  G) output+="Golf " ;;
  H) output+="Hotel " ;;
  I) output+="India " ;;
  J) output+="Juliet " ;;
  K) output+="Kilo " ;;
  L) output+="Lima " ;;
  M) output+="Mike " ;;
  N) output+="November " ;;
  O) output+="Oscar " ;;
  P) output+="Papa " ;;
  Q) output+="Quebec " ;;
  R) output+="Romeo " ;;
  S) output+="Sierra " ;;
  T) output+="Tango " ;;
  U) output+="Uniform " ;;
  V) output+="Victor " ;;
  W) output+="Whiskey " ;;
  X) output+="X-ray " ;;
  Y) output+="Yankee " ;;
  Z) output+="Zulu " ;;
  *) output+="$char " ;;
  esac
done

# Print output
echo $output
