#!/bin/bash
cd /mnt/data/vaultwarden && sudo docker compose up -d
cd /mnt/data/immich && sudo docker compose up -d
cd /mnt/data/pihole && sudo docker compose up -d
cd /mnt/data/portainer && sudo docker compose up -d
cd /mnt/data/mullvad && sudo docker compose up -d
cd /mnt/data/nextcloud && docker compose up -d
echo "homelab up and running"
