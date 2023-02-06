#!/usr/bin/swift

// Required parameters:
// @raycast.schemaVersion 1
// @raycast.title UUID
// @raycast.mode silent

// Optional parameters:
// @raycast.icon 🤖
// @raycast.packageName Custom

// Documentation:
// @raycast.description Generate a type 4 UUID
// @raycast.author Johan West
// @raycast.authorURL johanwest.com

import AppKit

let uuid = UUID().uuidString

NSPasteboard.general.clearContents()
NSPasteboard.general.writeObjects([uuid as NSPasteboardWriting])

print("Copied to clipboard")
