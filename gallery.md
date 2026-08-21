# Homelab Evidence Gallery

## Infrastructure & Services

### Pi-hole Dashboard

[![Pi-hole Stats](https://github.com/masonv7122/homelab/raw/main/images/pihole-dashboard.png)](/masonv7122/homelab/blob/main/images/pihole-dashboard.png)

DNS-level ad blocking protecting the entire network (31k queries, 11.1% blocked).

### Nginx Proxy Manager

[![Nginx Proxy Hosts](https://github.com/masonv7122/homelab/raw/main/images/nginx-proxy-manager.png)](/masonv7122/homelab/blob/main/images/nginx-proxy-manager.png)

All internal services exposed securely through reverse proxy with automatic SSL certificates.

### Portainer Environment

[![Portainer Overview](https://github.com/masonv7122/homelab/raw/main/images/portainer-environment.png)](/masonv7122/homelab/blob/main/images/portainer-environment.png)

Docker management interface showing 11 containers, 6 stacks, and 8.3GB RAM usage.

### All Containers Running

[![Docker PS Output](https://github.com/masonv7122/homelab/raw/main/images/docker-ps-output.png)](/masonv7122/homelab/blob/main/images/docker-ps-output.png)

Every service (Vaultwarden, Immich, Nextcloud, gluetun, etc.) running and healthy.

## Cybersecurity Lab

### Proxmox VM List

[![Proxmox VM List](https://github.com/masonv7122/homelab/raw/main/images/Proxmox%20VM%20list.png)](/masonv7122/homelab/blob/main/images/Proxmox%20VM%20list.png)

The Proxmox host running all four homelab VMs: pfsense, wazuh-manager, metasploitable2, and kali.

### pfSense Dashboard

[![pfSense Dashboard](https://github.com/masonv7122/homelab/raw/main/images/pfsense%20dashboard.png)](/masonv7122/homelab/blob/main/images/pfsense%20dashboard.png)

pfSense running as the real router/firewall, WAN and LAN interfaces both up.

### Nmap Scan Against Metasploitable2

[![Kali Nmap Scan](https://github.com/masonv7122/homelab/raw/main/images/Kali%20NMAP.png)](/masonv7122/homelab/blob/main/images/Kali%20NMAP.png)

Nmap scan from Kali against Metasploitable2, showing the full set of intentionally vulnerable services exposed on the target.

### Wazuh Agent Monitoring

[![Wazuh Dashboard](https://github.com/masonv7122/homelab/raw/main/images/Wazuh%20dashboard.png)](/masonv7122/homelab/blob/main/images/Wazuh%20dashboard.png)

Wazuh agent on Kali reporting in active, with detected activity already mapped to MITRE ATT&CK tactics (Defense Evasion, Privilege Escalation, Initial Access, Persistence).

### Suricata Rule Categories

[![Suricata Categories](https://github.com/masonv7122/homelab/raw/main/images/Suricata%20categories.png)](/masonv7122/homelab/blob/main/images/Suricata%20categories.png)

ET Open ruleset categories enabled on pfSense's WAN interface, covering exploits, malware, botnets, scanning, and more.

## Services in Action

### Vaultwarden Password Manager

[![Vaultwarden Vault](https://github.com/masonv7122/homelab/raw/main/images/vaultwarden-vault.png)](/masonv7122/homelab/blob/main/images/vaultwarden-vault.png)

Self-hosted password manager storing all credentials encrypted locally.

### Nextcloud File Sync

[![Nextcloud Files](https://github.com/masonv7122/homelab/raw/main/images/nextcloud-files.png)](/masonv7122/homelab/blob/main/images/nextcloud-files.png)

63.2GB of synced documents and downloads actively stored and organized.

### Immich Photo Library

[![Immich Photos](https://github.com/masonv7122/homelab/raw/main/images/immich-photos.png)](/masonv7122/homelab/blob/main/images/immich-photos.png)

4,207 photos and 3,576 videos automatically organized and indexed for search.

### Immich Admin Dashboard

[![Immich Server Stats](https://github.com/masonv7122/homelab/raw/main/images/immich-admin-stats.png)](/masonv7122/homelab/blob/main/images/immich-admin-stats.png)

Real-world scale: 21GB storage, ML-indexed photos, full video support.

## Remote Access & Security

### Tailscale Connected Devices

[![Tailscale Machines](https://github.com/masonv7122/homelab/raw/main/images/tailscale-machines.png)](/masonv7122/homelab/blob/main/images/tailscale-machines.png)

3 devices (Linux Pi, iOS, Windows) securely connected via zero-trust VPN.

## Automation & Proof

### Startup Script in Action

[![Homelab Start Script](https://github.com/masonv7122/homelab/raw/main/images/homelab-start-output.png)](/masonv7122/homelab/blob/main/images/homelab-start-output.png)

LUKS unlock, storage mount, and all 11 containers starting automatically in ~30 seconds.

### Physical Setup

[![Homelab Rack](https://github.com/masonv7122/homelab/raw/main/images/homelab%20rack.png)](/masonv7122/homelab/blob/main/images/homelab%20rack.png)

The physical stack: TP-Link access point on top, Netgear managed switch, and the Lenovo ThinkCentre M710q (Proxmox host) below it.

---

**All images show real, working infrastructure.** Everything runs 24/7.
