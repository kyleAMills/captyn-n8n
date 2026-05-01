#!/bin/sh
mkdir -p /home/node/.n8n
chown -R node:node /home/node
exec gosu node n8n
