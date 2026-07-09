#!/bin/sh

CURRENT_MODE=$(aerospace list-modes --current 2>/dev/null)

if [ "$CURRENT_MODE" != "main" ] && [ -n "$CURRENT_MODE" ]; then
  sketchybar --set "$NAME" drawing=on label="$CURRENT_MODE"
else
  sketchybar --set "$NAME" drawing=off
fi
