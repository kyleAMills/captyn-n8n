FROM node:20-bookworm-slim

RUN apt-get update && \
    apt-get install -y python3 python3-pip gosu && \
    pip3 install duckdb --break-system-packages && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n

RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node && chmod -R 775 /home/node

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5678

ENTRYPOINT ["/entrypoint.sh"]
