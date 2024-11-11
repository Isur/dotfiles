#!/bin/bash

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -eq 0 ]]; then
  sketchybar -m --set mic icon=:mic_off: label="Mute"
elif [[ $MIC_VOLUME -gt 0 ]]; then
  sketchybar -m --set mic icon=:mic_on: label="$MIC_VOLUME%"
fi

