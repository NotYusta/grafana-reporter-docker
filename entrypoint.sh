#!/bin/sh
set -e

# Optional: echo configuration for debug
echo "Starting Grafana Reporter..."
echo "Mode: ${CMD_ENABLE:-0}"

if [ "$CMD_ENABLE" = "1" ]; then
    echo "Running in command-line mode"
    grafana-reporter \
        -cmd_enable=1 \
        -cmd_apiKey="${CMD_API_KEY}" \
        -cmd_apiVersion="${CMD_API_VERSION:-v5}" \
        -cmd_dashboard="${CMD_DASHBOARD}" \
        -cmd_o="${CMD_OUTPUT:-out.pdf}" \
        -cmd_ts="${CMD_TS:-from=now-3h&to=now}" \
        ${CMD_TEMPLATE:+-cmd_template="$CMD_TEMPLATE"}
else
    echo "Running in web server mode"
    grafana-reporter \
        -ip="${GRAFANA_HOST:-localhost:3000}" \
        -port="${HTTP_PORT:-:8686}" \
        -proto="${GRAFANA_PROTO:-http://}" \
        -ssl-check="${GRAFANA_SSL_CHECK:-true}" \
        -templates="${GRAFANA_TEMPLATE_DIR:-templates/}"
fi
