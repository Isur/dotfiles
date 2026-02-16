#!/usr/bin/env bash
on="$(echo -e show | bluetoothctl | grep 'Powered: yes' -q && echo 'on' || echo 'off' )"

if [ "$on" == "on" ]; then
    bluetoothctl power off
else
    bluetoothctl power on
fi
