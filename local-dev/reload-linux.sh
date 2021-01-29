#!/usr/bin/env bash

# Usage:
# run ./watch.sh

echo $@

sleep 2

WID=$(xdotool search --name ".*- Grafana")
xdotool windowactivate ${WID}
xdotool key ctrl+F5
