FROM ghcr.io/openclaw/openclaw:latest

COPY --chown=node:node openclaw.yaml /home/node/.openclaw/openclaw.yaml

USER node

HEALTHCHECK --interval=30s --timeout=10s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:18789/health || exit 1

EXPOSE 18789
