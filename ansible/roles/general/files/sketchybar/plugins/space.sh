#!/bin/sh

FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null)

for i in $(seq 1 10); do
  if [ "$i" = "$FOCUSED" ]; then
    sketchybar --set space."$i" background.drawing=on icon.color=0xffffffff
  else
    sketchybar --set space."$i" background.drawing=off icon.color=0x40ffffff
  fi
done
