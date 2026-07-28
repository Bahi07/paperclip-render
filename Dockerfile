# Paperclip + Hermes Agent — Lightweight image for Render free tier
# Uses npm package instead of building from source (saves RAM + time)
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

# Create Paperclip home directories
RUN mkdir -p /paperclip/instances/default

# Environment variables
ENV NODE_ENV=production \
    HOME=/paperclip \
    HOST=0.0.0.0 \
    PORT=3100 \
    SERVE_UI=true \
    PAPERCLIP_HOME=/paperclip \
    PAPERCLIP_INSTANCE_ID=default \
    PAPERCLIP_CONFIG=/paperclip/instances/default/config.json \
    PAPERCLIP_DEPLOYMENT_MODE=authenticated \
    PAPERCLIP_DEPLOYMENT_EXPOSURE=private \
    PAPERCLIP_TELEMETRY_DISABLED=1

EXPOSE 3100

# Start script
COPY render-start.sh /render-start.sh
RUN chmod +x /render-start.sh

CMD ["/render-start.sh"]
