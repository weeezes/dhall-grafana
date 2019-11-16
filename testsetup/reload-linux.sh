#!/bin/bash

# Usage:
# inotifywait -m -e modify -r --exclude '.*.swp' dashboards/ | xargs -I{} /bin/bash -c 'echo "{}"; inotifywait -e close_nowrite --exclude '.*.swp' -r dashboards/' | xargs -I{} ./reload.sh {}

echo $#

sleep 2

WID=$(xdotool search --name ".*- Grafana")
xdotool windowactivate ${WID}
xdotool key ctrl+F5
