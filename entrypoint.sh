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

exec gosu openclaw node src/server.js
