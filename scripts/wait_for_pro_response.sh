#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  wait_for_pro_response.sh [seconds]

Sleeps once between ChatGPT Pro status checks. Defaults to 300 seconds.
EOF
}

if [ "${1:-}" = "-h" ] || [ "${1:-}" = "--help" ]; then
  usage
  exit 0
fi

if [ "$#" -gt 1 ]; then
  usage >&2
  exit 2
fi

seconds="${1:-300}"

case "$seconds" in
  ''|*[!0-9]*)
    echo "Error: seconds must be a non-negative integer" >&2
    exit 2
    ;;
esac

echo "Sleeping for ${seconds}s before the next ChatGPT Pro status check."
echo "Started:  $(date '+%Y-%m-%d %H:%M:%S %Z')"
sleep "$seconds"
echo "Finished: $(date '+%Y-%m-%d %H:%M:%S %Z')"
