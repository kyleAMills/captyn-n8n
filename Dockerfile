FROM node:20-bookworm-slim

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install duckdb --break-system-packages && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n

USER node

EXPOSE 5678

CMD ["n8n", "start"]
