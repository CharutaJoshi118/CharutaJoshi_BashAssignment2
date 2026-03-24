import ping_scanner
import arp_scanner
import nmap_scanner
import ipaddress
import subprocess
from concurrent.futures import ThreadPoolExecutor

def scan_ip(ip):
    try:
        result = subprocess.run(
            ["ping", "-c", "1", "-W", "1", str(ip)],  # -W 1 = 1 second timeout
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        if result.returncode == 0:
            print(f"{ip} is ACTIVE")
        else:
            print(f"{ip} is DOWN")
    except Exception as e:
        print(f"Error scanning {ip}: {e}")

def range_scan():
    net_input = input("Enter network (e.g. 192.168.1.0/24): ")
    try:
        net = ipaddress.ip_network(net_input, strict=False)
        hosts = list(net.hosts())
        print(f"\nScanning {len(hosts)} hosts...\n")
        
        with ThreadPoolExecutor(max_workers=50) as executor:  # Increased workers
            executor.map(scan_ip, hosts)
        
        print("\nScan complete.")
    except ValueError:
        print("Invalid network format")

def main():
    while True:
        print("\n===== NETWORK SCANNER =====")
        print("1. Ping Scanner")
        print("2. ARP Scanner")
        print("3. Nmap Scanner")
        print("4. Network Range Scan")
        print("5. Exit")
        choice = input("Enter choice: ")
        if choice == '1':
            ping_scanner.main()
        elif choice == '2':
            arp_scanner.main()
        elif choice == '3':
            nmap_scanner.main()
        elif choice == '4':
            range_scan()
        elif choice == '5':
            break
        else:
            print("Invalid choice")

if __name__ == "__main__":
    main()
