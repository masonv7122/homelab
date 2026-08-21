# Architecture

Full infrastructure writeup: network design, virtualization host, Docker services, and automation.

## Network Design

**ISP handoff:** Xfinity gateway is set to bridge/modem-only mode - no routing, WiFi, or DHCP. It's a pure modem now; all of that is handled downstream.

**Router/firewall:** pfSense CE 2.8.1, running as a VM on Proxmox, is the real router for the network.
- WAN interface: a j5create USB-to-Ethernet adapter connected to the Proxmox host, getting a public IP via DHCP from the Xfinity gateway.
- LAN interface: served by the onboard NIC on the Proxmox host.
- DHCP: a dynamic pool covering most of the LAN subnet, with a handful of addresses reserved outside the pool for static assignments.
- DNS Resolver: host overrides configured for every internal subdomain, pointing them to the Pi. This is necessary because without an override, requesting my own domains from inside the network resolves to my public IP and can't loop back in cleanly (NAT hairpin) - the override avoids that entirely. (After adding/changing overrides, a DNS flush is needed on the client.)
- NAT: ports 80/443 forwarded to the Pi for public-facing services.

**Access point:** The TP-Link Archer AX1500 was demoted from router to Access-Point-only mode. It still broadcasts the original WiFi SSIDs/passwords unchanged, but no longer handles routing or DHCP - pfSense owns that now.

**Switch:** Netgear 8-port managed switch sits between pfSense, the AP, the Pi, and the Proxmox host. VLAN-capable, currently flat, VLANs planned.

## Proxmox Host

Lenovo ThinkCentre M710q Tiny (i5-6500T/7500T), running Proxmox VE 9.2, with a static LAN IP and its own web UI.

Note: Proxmox's web UI is deliberately **not** proxied through Nginx Proxy Manager. NPM can't correctly pass through the WebSocket connection Proxmox's console/VNC (noVNC) requires - tried `proxy_http_version 1.1`, `Upgrade`/`Connection` headers in both the Advanced tab and Custom Locations, none of it resolved the protocol violation. Direct access to the Proxmox web UI with a bookmarked, accepted self-signed cert is the correct, intentional setup - not an unfinished piece.

### VMs

| VM | Role | Specs | Network |
|---|---|---|---|
| pfsense | Router/firewall, Suricata IDS (WAN, ET Open rules) | 2GB RAM (ballooning, 1536MB min), 16GB disk | WAN: USB adapter (public IP) / LAN: internal subnet |
| wazuh-manager | SIEM - monitors Kali (host-based) | Ubuntu 22.04, 3072MB RAM (ballooning, ~2048MB min), 38GB disk | LAN |
| kali | Cybersecurity lab attacker box | 3072MB RAM (ballooning, 1536MB min), 60GB disk | vmbr2 (isolated) |
| metasploitable2 | Cybersecurity lab target | 512MB RAM (ballooning, ~384MB min), 8GB disk, IDE bus | vmbr2 (isolated) |

`vmbr2` is an isolated internal Proxmox bridge with no physical NIC attached - fully cut off from the real LAN and internet, used exclusively for the cybersecurity lab (see [CYBERSECURITY-LAB.md](CYBERSECURITY-LAB.md)).

## Raspberry Pi 5 - Docker Host

Assigned a static LAN IP outside pfSense's dynamic DHCP pool range, so its address never changes. Storage is a 512GB external SSD, LUKS-encrypted, manually unlocked at boot before containers start.

Startup sequence, orchestrated by `/usr/local/bin/homelab-start.sh`:
1. LUKS volume unlock
2. Mount to `/mnt/data`
3. All containers start in sequence

`/usr/local/bin/homelab-stop.sh` is always run before any physical power-off, to avoid data corruption on the encrypted volume.

### Services & Reverse Proxy

All services sit behind Nginx Proxy Manager, with a wildcard cert covering every subdomain except Vaultwarden (which predates the wildcard cert and uses the bare domain directly).

| Service | Internal Port | Notes |
|---|---|---|
| Nextcloud | 8081 | File sync, MariaDB backend |
| Vaultwarden | 8080 | Bare domain, no wildcard needed |
| Nginx Proxy Manager | 81 | Admin UI |
| Pi-hole | 8053 | DNS ad blocking |
| Portainer | 9000 | Container management |
| Immich | 2283 | Photo/video backup + ML search |

## Immich USB Backup Automation

Fully automated, hands-off backup path:
1. Plug the designated backup USB drive (ext4) into the Pi.
2. A udev rule detects the drive and triggers a backup script via `systemd-run --no-block`. This is the key detail - udev has a ~2 minute process timeout, which was killing long-running rsync jobs before the fix; `systemd-run --no-block` hands the job off outside of udev's timeout window.
3. The script mounts the drive, rsyncs the Immich data directory to it, logs progress, and auto-unmounts when finished.
4. Script gets around 1gb every 70 seconds, so the process is usually 40-50 minutes. Repeat 1-2 times a week to prevent unexpected corruption or data loss.
5. Log is checked for a "Backup finished, unmounting" line before physically unplugging the drive.

