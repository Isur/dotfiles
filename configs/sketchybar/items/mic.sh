#!/bin/bash

sketchybar -m --add item mic right
sketchybar -m --set mic icon.font="sketchybar-app-font:Regular:16.0"    \
                        script="$PLUGIN_DIR/mic.sh"                     \
                        click_script="$PLUGIN_DIR/mic_click.sh"         \
                        update_freq=3
