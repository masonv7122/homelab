# Homelab: Self-Hosted Infrastructure & Cybersecurity Lab

A self-hosted homelab built around a Raspberry Pi 5 (Docker host) and a dedicated virtualization server (Proxmox), running production-style infrastructure and an isolated cybersecurity attack/defense lab. Built by a Statistics major (Penn State) with a CompTIA Security+ certification, targeting help desk / IT support / junior security roles.

## Network Architecture

```
Internet
   │
Xfinity Gateway (bridge/modem-only mode - no routing, no WiFi, no DHCP)
   │
pfSense VM (Proxmox) - real router/firewall
   │
Netgear 8-Port Managed Switch
   │
   ├── TP-Link Archer AX1500 - demoted to Access Point only
   │     (broadcasts original WiFi SSIDs, no routing/DHCP)
   │
   ├── Raspberry Pi 5 - Docker host (static LAN IP)
   │
   └── Lenovo M710q Tiny - Proxmox VE 9.2 host
         ├── pfSense VM
         ├── Wazuh Manager VM
         └── vmbr2 (isolated internal bridge, no internet access)
               ├── Kali Linux
               └── Metasploitable2
```

**Key point:** the Pi and the Proxmox server are two independent hosts. All homelab VMs run 24/7 on the Proxmox server regardless of whether the Pi or my laptop are on. Full breakdown in [ARCHITECTURE.md](ARCHITECTURE.md).

---

## What's Running

### Raspberry Pi 5 - Docker Host

LUKS-encrypted external SSD, 10+ containers, automated startup/shutdown.

- **Nextcloud** + MariaDB - file sync, WebDAV
- **Vaultwarden** - self-hosted password manager (Bitwarden-compatible), sole autofill source
- **Nginx Proxy Manager** - reverse proxy + automatic SSL for every internal service
- **Pi-hole** - network-wide DNS ad blocking
- **Portainer** - container management
- **Immich** - photo/video backup with ML-powered search, fully automated USB backup on top of the primary encrypted storage
- **gluetun** (Mullvad VPN container) - in progress, see Known Issues below

### Lenovo M710q - Proxmox Virtualization Host

- **pfSense CE 2.8.1** - the actual router/firewall for the whole network. Runs Suricata IDS on the WAN interface (ET Open ruleset).
- **Wazuh Manager** - SIEM/host-based monitoring, watching the Kali VM
- **Kali Linux** + **Metasploitable2** - isolated cybersecurity lab (see [CYBERSECURITY-LAB.md](CYBERSECURITY-LAB.md))

---

## Skills Demonstrated

**Networking & Routing:** pfSense firewall/router configuration, DHCP/DNS management, NAT and port forwarding, reverse proxy + SSL termination, VLAN-ready managed switch

**Virtualization:** Proxmox VE - VM provisioning, resource allocation (RAM ballooning, disk bus troubleshooting), isolated virtual networks

**Security:** IDS deployment (Suricata), SIEM deployment (Wazuh), host-based monitoring agents, full-disk encryption (LUKS), secrets management (Vaultwarden), Security+ fundamentals applied hands-on

**Linux Administration & Automation:** Bash scripting, systemd services, udev rules, LVM management, Docker/Docker Compose orchestration

**Troubleshooting:** real infrastructure problems solved and documented - disk bus incompatibilities, LVM resize, disk-filling misconfigurations, process timeout issues in automation - see [ARCHITECTURE.md](ARCHITECTURE.md) and [CYBERSECURITY-LAB.md](CYBERSECURITY-LAB.md) for the specifics.

---

## Known Issues / In Progress

- **gluetun (Mullvad VPN container)** is currently crash-looping on the Pi. This is the planned tunnel for the future Jellyfin/*arr stack - troubleshooting in progress.

---

## Roadmap

**Done**
- ✅ Nextcloud
- ✅ Mini PC / Proxmox setup
- ✅ pfSense (real router/firewall, TP-Link demoted to AP)
- ✅ USB backup automation for Immich
- ✅ Cybersecurity Lab - Kali + Metasploitable2 + Wazuh Manager, isolated on their own virtual network

**Planned**
- ⬜ Dual-boot main laptop with Debian + Windows (interacting with Proxmox VMs via noVNC)
- ⬜ VLANs (pfSense + Netgear managed switch)
- ⬜ Yubikey hardware 2FA
- ⬜ Fix gluetun crash loop, then Mullvad VPN kill switch
- ⬜ Jellyfin + *arr stack (tunneled through gluetun)
- ⬜ Grafana + rack-mounted LCD dashboard
- ⬜ Ollama/AI node

---

## More

- [ARCHITECTURE.md](ARCHITECTURE.md) - full network/infrastructure writeup
- [CYBERSECURITY-LAB.md](CYBERSECURITY-LAB.md) - the isolated attack/defense lab, in detail
- [gallery.md](gallery.md) - screenshots and evidence

---

**Last Updated:** August 2026
**GitHub:** [masonv7122](https://github.com/masonv7122)
**Email:** mason@luedecke.dev
