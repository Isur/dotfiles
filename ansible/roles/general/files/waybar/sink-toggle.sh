#!/usr/bin/env bash

sinks=($(pactl list short sinks | awk '{print $2}'))

default_sink=$(pactl get-default-sink)

if [ "$default_sink" == "${sinks[0]}" ]; then
    pactl set-default-sink "${sinks[1]}"
else
    pactl set-default-sink "${sinks[0]}"
fi
