#!/bin/sh
# Volume is mounted at /home/node. We create .n8n as a subdirectory
# inside it — root can chown a new subdir it created, unlike the mount root.
mkdir -p /home/node/.n8n
chown node:node /home/node/.n8n
exec gosu node n8n
