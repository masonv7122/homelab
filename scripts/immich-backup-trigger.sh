#!/bin/bash
sleep 5
mount UUID=<ENTER UUID HERE> /mnt/immich-backup
/usr/local/bin/immich-backup.sh
