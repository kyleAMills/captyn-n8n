FROM node:20-bookworm-slim

RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv gosu git && \
    pip3 install duckdb --break-system-packages && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g n8n

# n8n's Python Code node requires a Python task runner at this exact path.
# The source is not bundled in the npm package — fetch it from GitHub.
RUN git clone --depth 1 --filter=blob:none --sparse \
      https://github.com/n8n-io/n8n.git /tmp/n8n-src && \
    cd /tmp/n8n-src && \
    git sparse-checkout set "packages/@n8n/task-runner-python" && \
    mkdir -p /usr/local/lib/node_modules/@n8n && \
    cp -r "packages/@n8n/task-runner-python" /usr/local/lib/node_modules/@n8n/ && \
    rm -rf /tmp/n8n-src

# Create the venv n8n looks for, with packages the workflow uses.
RUN cd /usr/local/lib/node_modules/@n8n/task-runner-python && \
    python3 -m venv .venv && \
    .venv/bin/pip install --no-cache-dir websockets duckdb

RUN mkdir -p /home/node/.n8n && chown -R node:node /home/node && chmod -R 775 /home/node

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 5678

ENTRYPOINT ["/entrypoint.sh"]
