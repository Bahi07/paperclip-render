#!/bin/sh
set -e

echo "=== Paperclip + Hermes Agent Starting ==="

# Ensure directories exist
mkdir -p "$PAPERCLIP_HOME/instances/default"

# Verify Hermes Agent is available
echo "[init] Checking Hermes Agent..."
hermes --version && echo "[init] Hermes Agent OK" || echo "[warn] Hermes Agent not found"

# Check if config exists; if not, create minimal one
if [ ! -f "$PAPERCLIP_CONFIG" ]; then
    echo "[init] Creating config..."
    cat > "$PAPERCLIP_CONFIG" <<CFGEOF
{
  "server": {
    "host": "0.0.0.0",
    "port": 3100
  },
  "database": {
    "url": "$DATABASE_URL"
  },
  "deployment": {
    "mode": "trusted",
    "exposure": "private"
  }
}
CFGEOF
    echo "[init] Config created at $PAPERCLIP_CONFIG"
fi

echo "[init] Starting Paperclip server..."
exec node $(npm root -g)/paperclipai/dist/index.js run --yes 2>&1
