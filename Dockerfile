# Paperclip + Hermes Agent — Lightweight image for Render free tier
FROM node:20-slim

# Install system dependencies + Python for Hermes Agent CLI
RUN apt-get update \
  && apt-get install -y --no-install-recommends \
    ca-certificates curl git ripgrep jq \
    python3 python3-pip \
  && pip3 install --break-system-packages hermes-agent \
  && rm -rf /var/lib/apt/lists/*

# Install Paperclip CLI globally (pre-built npm package)
RUN npm install -g paperclipai@latest

# Create directories for Paperclip
RUN mkdir -p /paperclip/instances/default

# Environment variables - use Render's dynamic PORT
ENV NODE_ENV=production \
    HOME=/paperclip \
    HOST=0.0.0.0 \
    SERVE_UI=true \
    PAPERCLIP_HOME=/paperclip \
    PAPERCLIP_INSTANCE_ID=default \
    PAPERCLIP_CONFIG=/paperclip/instances/default/config.json \
    PAPERCLIP_DEPLOYMENT_MODE=authenticated \
    PAPERCLIP_DEPLOYMENT_EXPOSURE=private \
    PAPERCLIP_TELEMETRY_DISABLED=1

EXPOSE 3100

# Start script: use Render's $PORT, create config, then run Paperclip
CMD ["sh", "-c", "mkdir -p /paperclip/instances/default && echo '{"server":{"host":"0.0.0.0","port":'${PORT:-10000}'},"database":{"url":"'$DATABASE_URL'"}}' > /paperclip/instances/default/config.json && echo 'Config: ' && cat /paperclip/instances/default/config.json && paperclipai run --yes"]
