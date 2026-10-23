#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title AeroSpace Keys
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon ⌨️
# @raycast.packageName AeroSpace
# @raycast.argument1 { "type": "text", "placeholder": "filter", "optional": true }

# Documentation:
# @raycast.description Cheat sheet of AeroSpace keybindings, read live from ~/.aerospace.toml. Workspace switching is left out.
# @raycast.author andri

exec "$HOME/.local/bin/aerokeys" "$@"
