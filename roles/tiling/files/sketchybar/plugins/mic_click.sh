#!/bin/bash

MIC_VOLUME=$(osascript -e 'input volume of (get volume settings)')

if [[ $MIC_VOLUME -lt 25 ]]; then
  osascript -e 'set volume input volume 25'
  sketchybar -m --set mic icon=:mic_on: label="25"
elif [[ $MIC_VOLUME -lt 50 ]]; then
  osascript -e 'set volume input volume 50'
  sketchybar -m --set mic icon=:mic_on: label="50"
elif [[ $MIC_VOLUME -lt 75 ]]; then
  osascript -e 'set volume input volume 75'
  sketchybar -m --set mic icon=:mic_on: label="75"
elif [[ $MIC_VOLUME -lt 100 ]]; then
  osascript -e 'set volume input volume 100'
  sketchybar -m --set mic icon=:mic_on: label="100"
else
  osascript -e 'set volume input volume 0'
  sketchybar -m --set mic icon=:mic_off: label="Mute"
fi
