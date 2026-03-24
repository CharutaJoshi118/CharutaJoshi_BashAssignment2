# Network Scanning Automation
**Course:** Cybersecurity | **Institution:** CampusPe | **Mentor:** Jacob Dennis

---

## Project Description

This project automates three essential network scanning tools using Python: **Ping**, **ARP**, and **Nmap**. It includes a unified scanner that combines all three tools into a single menu-driven interface, with bonus features like multi-threaded scanning, network range scanning, CSV export, and logging with timestamps.

---

## Project Structure

```
network-scanning-tools/
├── ping_scanner.py          # Ping automation tool
├── arp_scanner.py           # ARP table scanner
├── nmap_scanner.py          # Nmap automation tool
├── network_scanner.py       # Unified scanner (all tools combined)
├── logger.py                # Logging module with timestamps
├── csv_export.py            # CSV export module
├── arp_results.csv          # ARP scan results (CSV)
├── arp_results.txt          # ARP scan results (text)
├── nmap_results.csv         # Nmap scan results (CSV)
├── nmap_results.txt         # Nmap scan results (text)
├── ping_results.csv         # Ping scan results (CSV)
├── scan_log.txt             # Activity log with timestamps
├── README.md                # This file
└── screenshots-touch/
    ├── ARP_scanner.png          # ARP scanner output
    ├── ping_scanner/            # Ping scanner screenshots
    ├── nmap_scanner_outputs/    # Nmap scanner screenshots
    ├── bonus/                   # Bonus features screenshots
    └── error_handling/          # Error handling screenshots
```

---

## How to Run the Scripts

**First time only — make all scripts executable:**
```bash
chmod +x *.sh
```

---

## How to Install Nmap

### Linux (Kali)
```bash
sudo apt-get update
sudo apt-get install nmap
```

### Windows
Download from: https://nmap.org/download.html  
Run the installer and follow the setup wizard.

### Mac
```bash
brew install nmap
```

### Verify Installation
```bash
nmap --version
```

---

## How to Run Each Program

### 1. Ping Scanner
```bash
python3 ping_scanner.py
```
- Enter a single hostname or IP address
- Or choose multiple host scanning
- Displays status (Reachable/Unreachable) and response time
- Results saved to `ping_results.csv`

### 2. ARP Scanner
```bash
python3 arp_scanner.py
```
- Automatically retrieves the system ARP table
- Displays IP-to-MAC address mappings in a formatted table
- Results saved to `arp_results.txt` and `arp_results.csv`

### 3. Nmap Scanner
```bash
sudo python3 nmap_scanner.py
```
- Enter target IP or network range
- Choose from multiple scan types:
  - Basic Host Discovery (-sn)
  - Port Scan (1-1000)
  - Service Version Detection (-sV)
  - OS Detection (-O)
  - Custom port range
- Results saved to `nmap_results.txt` and `nmap_results.csv`

### 4. Unified Network Scanner (Bonus)
```bash
sudo python3 network_scanner.py
```
- Menu-driven interface combining all three tools
- Includes Network Range Scan (e.g., 192.168.237.0/24)
- Multi-threaded scanning with 50 workers for speed
- All activity logged to `scan_log.txt` with timestamps

---

## Example Usage

### Ping Scanner
```
=== Ping Scanner ===
Ping single host? (y/n): y
Enter hostname or IP: 192.168.237.1

Host: 192.168.237.1
Status: Reachable
Average Time: 1ms
```

### ARP Scanner
```
=== ARP Scanner ===
Scanning ARP table...

IP Address        MAC Address
-----------------------------------------------
192.168.237.1     00:50:56:xx:xx:xx
192.168.237.2     00:50:56:xx:xx:xx

Total entries: 2
```

### Nmap Scanner
```
=== Nmap Scanner ===
Nmap is installed
Enter target IP or network: 192.168.237.1
Select scan type:
1. Basic Host Discovery (-sn)
2. Port Scan (1-1000)
3. Service Version Detection (-sV)
Enter choice (1-3): 2

Scanning... (this may take a while)
Scan completed successfully

PORT      STATE  SERVICE
22/tcp    open   ssh
80/tcp    open   http
```

### Network Range Scan (Bonus)
```
===== NETWORK SCANNER =====
Enter choice: 4
Enter network (e.g. 192.168.1.0/24): 192.168.237.0/24

Scanning 254 hosts... (Press Ctrl+C to stop)

192.168.237.1 is ACTIVE
192.168.237.2 is ACTIVE
192.168.237.128 is ACTIVE

Scan complete.
```

---

## Bonus Features Implemented

| Feature | Status |
|---|---|
| Unified scanner combining all three tools | ✅ Done (`network_scanner.py`) |
| Export results to CSV format | ✅ Done (`csv_export.py`) |
| Network range scanning (e.g., 192.168.237.0/24) | ✅ Done |
| Multi-threaded scanning for speed | ✅ Done (50 workers) |
| Logging functionality with timestamps | ✅ Done (`logger.py`, `scan_log.txt`) |

---

## Requirements

- Python 3.6 or higher
- Nmap installed on system
- Run with `sudo` for ARP and Nmap scans (root privileges required)

---

## Important Notes

- **Only scan networks you own or have explicit permission to scan**
- Unauthorized network scanning is illegal and unethical
- Test programs on your local network first
- Some Nmap scans require administrator/root privileges
