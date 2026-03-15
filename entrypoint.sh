#!/bin/bash
set -e
chown -R openclaw:openclaw /data
chmod 700 /data
if [ ! -d /data/.linuxbrew ]; then
  cp -a /home/linuxbrew/.linuxbrew /data/.linuxbrew
fi
rm -rf /home/linuxbrew/.linuxbrew
ln -sfn /data/.linuxbrew /home/linuxbrew/.linuxbrew
# Persist gogcli config on Railway volume
mkdir -p /data/gogcli /home/openclaw/.config
ln -sfn /data/gogcli /home/openclaw/.config/gogcli
# Write gogcli credentials from env var
if [ -n "$GOG_OAUTH_CLIENT_JSON" ]; then
  echo "$GOG_OAUTH_CLIENT_JSON" > /data/gogcli/credentials.json
  chmod 600 /data/gogcli/credentials.json
  chown openclaw:openclaw /data/gogcli/credentials.json
fi
exec gosu openclaw node src/server.js
