# Cybersecurity Lab

An isolated attack/defense lab built on Proxmox, used to run hands-on offensive security exercises (Nmap, Metasploit) in a network fully cut off from the real LAN and internet.

## Lab Topology

- **vmbr2** - an isolated internal Proxmox bridge with no physical NIC attached. Devices on it can reach each other but have no path to the real LAN or the internet.
- **Kali Linux** - installed from the official Kali ISO (not a pre-built VirtualBox/VMware image), so the build itself is from scratch. Comes with Wireshark pre-installed and configured for traffic capture on this network.
- **Metasploitable2** - the intentionally vulnerable target VM. Imported from a VMware-exported disk, which required changing the virtual disk bus from VirtIO SCSI to IDE (the old vmdk threw a "root does not exist" boot error on SCSI - a compatibility issue with how the original image was built, not a Proxmox bug).

Both VMs run continuously on the Proxmox host, independent of any other machine being on.

## Monitoring: Wazuh + Suricata

- **Wazuh Manager** (Ubuntu Server 22.04) provides host-based monitoring for the Kali VM, which runs the Wazuh agent and reports in.
  - Build note: the Ubuntu installer only allocated 19GB of a 38GB disk by default - fixed with `lvextend` + `resize2fs` to reclaim the rest.
  - Wazuh's install script also has a minimum-RAM check that the VM didn't initially meet; bypassed with the `-i` flag during setup, then the VM's RAM was permanently bumped to meet the real requirement.
  - Later troubleshooting: the disk filled to 100% because Wazuh's Vulnerability Detection module was downloading the full CVE database set (~27GB) into its queue directories. Fixed by disabling that module in `ossec.conf` and clearing the downloaded data - a good example of diagnosing a resource issue down to its actual cause rather than just freeing space and moving on.
- **Suricata** runs on pfSense, monitoring WAN-facing traffic with the ET Open ruleset (exploit, malware, scan, and related categories enabled). This is real, working IDS coverage for the actual network perimeter.

## Scope Decision: Why the Lab Traffic Itself Isn't Wazuh/Suricata-Monitored

Two real architecture constraints came up during the build:
- **Metasploitable2 can't run a modern Wazuh agent.** Its legacy libc/GLIBC is too old for the current agent binaries (symbol lookup errors on install) - it's an intentionally outdated distro, so this is expected, not a misconfiguration.
- **Suricata doesn't see vmbr2 traffic.** vmbr2 is fully isolated and doesn't route through pfSense, so pfSense's WAN-facing Suricata instance has no visibility into anything happening inside the lab.

Rather than fighting infrastructure that isn't built for this use case, the lab uses **Kali's own built-in tools - Wireshark and tcpdump - to observe attack traffic directly on the isolated network.** Wazuh and Suricata remain legitimate, working monitoring for what they're actually positioned to see (the Kali host itself, and real WAN traffic, respectively).

## Exercises Log

A running log of exercises run against Metasploitable2 from Kali. I'll add entries here myself as I go.

| Date | Tool(s) | Target | What I Found / Learned |
|---|---|---|---|
| | | | |

