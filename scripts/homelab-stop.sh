#!/bin/bash
cd /mnt/data/portainer && sudo docker compose down
cd /mnt/data/pihole && sudo docker compose down
cd /mnt/data/immich && sudo docker compose down
cd /mnt/data/vaultwarden && sudo docker compose down
cd /mnt/data/nextcloud && sudo docker compose down
cd /mnt/data/mullvad && docker compose down
cd ~
sudo umount /mnt/data
sudo cryptsetup luksClose data
echo "homelab cleanly shut down"
