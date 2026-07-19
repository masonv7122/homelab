# Homelab: Self-Hosted Infrastructure

A self-hosted setup built on a Raspberry Pi 5 running 10+ Docker services. The goal: own my data, understand infrastructure, and learn by doing.

## Network Architecture

```
Internet (Xfinity Gateway)
           ↓
      TP-Link AX1500 Router
           ↓
    Netgear 8-Port Switch (Port 2)
           ↓
    Raspberry Pi 5 (Port 8)
      ├─ 512GB Encrypted SSD
      ├─ Docker Services
      └─ Tailscale VPN
```

**Key points:** Gateway → Router → Managed Switch → Pi. Everything else is inside containers or remote tunnels.

---

## What's Running

**Password Management:** Vaultwarden (self-hosted Bitwarden)
- All my passwords, encrypted and stored locally
- Syncs to browser extension and mobile

**Photo Backup:** Immich  
- 4,207 photos + 3,576 videos currently stored
- ML-powered search (object detection)
- 21GB storage on encrypted SSD

**File Sync:** Nextcloud
- Desktop sync to Windows/macOS (two-way)
- WebDAV for cross-platform access
- 65GB of synced files

**Reverse Proxy:** Nginx Proxy Manager
- Single entry point for all services
- Automatic SSL certificates via Let's Encrypt
- Wildcard cert covers all internal domains

**Network Protection:** Pi-hole
- DNS-level ad blocking (blocks 11.1% of queries)
- Network-wide protection for all devices

**Remote Access:** Tailscale VPN
- Zero-trust peer-to-peer tunneling
- SSH from anywhere without port forwarding
- 3 devices currently connected

**VPN Privacy:** Mullvad (via gluetun container)
- WireGuard protocol for speed
- Kill switch prevents IP leaks
- Ready for privacy-sensitive downloads

**Container Management:** Portainer + Docker
- 10+ containers running on encrypted storage
- Automated startup/shutdown via custom scripts
- Full orchestration via Docker Compose

**Databases:** PostgreSQL (with pgvector for ML), MariaDB, Redis

---

## Evidence It Works

**Startup Automation**
Here's what happens when I run `homelab-start.sh`:
- LUKS volume unlocks
- Storage mounts
- All 11 containers start in sequence
- Everything online in ~30 seconds

**All Containers Running**
Every service healthy and online (37+ minutes uptime shown):
- Nginx Proxy Manager, Vaultwarden, Immich stack (5 containers), Pi-hole, Portainer, gluetun, Nextcloud stack (2 containers)

**Immich Stats**
Real-world scale: 4,207 photos, 3,576 videos, 21GB of data actively managed and searchable.

**Tailscale Connected**
3 machines (Linux, iOS, Windows) all connected securely, all showing "Connected" status.

---

## Security Approach

**Data at Rest:** LUKS full-disk encryption on the SSD — password protected, AES-256

**Network:** Reverse proxy hides everything behind Nginx. No direct access to internal services from the internet.

**Traffic:** SSL/TLS on everything. Automatic certificate renewal via Let's Encrypt.

**Remote Access:** Zero-trust VPN (Tailscale) instead of port forwarding. Private key authentication.

**VPN Privacy:** Mullvad container with kill switch for privacy-sensitive services.

**No Port Forwarding Needed:** Tailscale handles remote access. Ports 80/443 are only for public services (which sit behind the reverse proxy).

---

## Tech Stack (What I Actually Use)

**OS & Infrastructure:**
- Ubuntu 24.04 LTS
- Docker & Docker Compose
- LUKS encryption
- Bash automation scripts

**Networking:**
- Reverse proxy (SSL/TLS termination)
- DNS configuration (Pi-hole)
- VPN tunneling (Tailscale, WireGuard)
- Managed switch (VLAN-capable, future use)

**Security:**
- Full-disk encryption (LUKS)
- SSL certificate management
- Zero-trust VPN
- Firewall basics (UFW)

**Databases:**
- PostgreSQL with pgvector (ML embeddings)
- MariaDB (relational data)
- Redis (caching)

---

## How I Access Everything

**Local Network:** Tailscale IP (100.x.x.x) from any connected device

**From Anywhere:** SSH via Tailscale tunnel — no public SSH exposure

**Web Services:** Through reverse proxy (nginx) with automatic HTTPS

**Automation:** Custom startup/shutdown scripts that orchestrate the entire stack

---

## Roadmap

**Done:**
- Vaultwarden, Immich, Nextcloud, Nginx Proxy Manager
- Tailscale VPN integration
- Mullvad/WireGuard privacy setup
- LUKS encryption + automated boot sequence
- Docker orchestration

**Next:**
- Mini PC (Lenovo M710q) + Proxmox for virtualization
- USB backup automation for Immich
- VLANs on managed switch
- Jellyfin + *arr stack (media + downloads)

**Future:**
- Grafana dashboard with rack LCD
- Cybersecurity VM lab for threat detection
- Ollama for local AI inference
- pfSense VM for advanced routing

---

## Skills This Demonstrates

**Linux Administration:**
- System management, file permissions, package management
- LUKS encryption, mount automation, systemd services
- Bash scripting for infrastructure automation

**Docker & Containerization:**
- Multi-container orchestration with Docker Compose
- Volume management, networking, restart policies
- Container debugging and log analysis

**Networking:**
- Reverse proxy configuration (SSL/TLS termination)
- DNS setup and management
- VPN technologies (WireGuard, zero-trust architecture)
- Managed switch configuration
- DHCP and static IP management

**Security & Encryption:**
- Full-disk encryption (LUKS)
- SSL/TLS certificate management
- Secrets management (Vaultwarden)
- Network security best practices

**System Design:**
- Architecture planning (how services communicate)
- Data persistence and backup strategy
- High availability and automated recovery

---

## Physical Setup

This isn't just virtual, it's all real pieces of hardware running 24/7:
- Raspberry Pi 5 in a proper rack
- Managed network switch for future scalability
- Encrypted SSD for data protection
- Router and gateway handling the network

---

## Getting Started (If You Want to Replicate)

1. **Encrypt your storage:** `cryptsetup luksFormat /dev/sdX`
2. **Install Docker:** Standard Ubuntu package
3. **Clone service configs** to `/mnt/data/`
4. **Create startup/shutdown scripts** to orchestrate the boot sequence
5. **Set up reverse proxy** (Nginx Proxy Manager) for public access
6. **Install Tailscale** on the host for remote access

---

## What's Next for Me

After the Mini PC is up and running Proxmox, the plan is:
- Document the entire setup on GitHub
- Update resume with hands-on infrastructure experience
- Start looking for help desk / junior sysadmin roles

---

**Last Updated:** July 19, 2026  
**GitHub:** [masonv7122](https://github.com/masonv7122)  
**Email:** mason@luedecke.dev
