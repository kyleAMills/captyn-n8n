#!/bin/sh
mkdir -p /home/node/.n8n
chown -R node:node /home/node/.n8n
chmod -R 775 /home/node/.n8n
exec n8n start
