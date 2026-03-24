import subprocess
import platform
import re
import sys
from logger import log
from csv_export import save_arp_csv

#run arp command to get the arp table
def get_arp_table():
    os_type = platform.system().lower()
    try:
        # arp -n on linux, arp -a on windows
        if os_type == 'windows':
            result = subprocess.run(['arp', '-a'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=10)
        else:
            result = subprocess.run(['arp', '-n'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=10)
        if result.returncode != 0:
            print("Error running arp command")
            return None
        return result.stdout
    except subprocess.TimeoutExpired:
        print("ARP command timed out")
        return None
    except Exception as e:
        print("Error:", str(e))
        return None

# Extract IP and MAC addresses
def parse_arp_output(output):
    os_type = platform.system().lower()
    entries = []
    for line in output.splitlines():
        if os_type == 'windows':
           match = re.search(r'(\d+\.\d+\.\d+\.\d+)\s+([\w-]{17})', line)
        else:
           match = re.search(r'(\d+\.\d+\.\d+\.\d+)\s+\S+\s+([0-9a-f:]{17})', line)
        if match:
               ip = match.group(1)
               mac = match.group(2)
               entries.append((ip, mac))
    return entries

# prints arp table in a nice format
def display_results(entries):
    if not entries:
        print("No ARP entries found.")
        return
    print("\n------ ARP Table ------")
    print(f"{'IP Address':<20} {'MAC Address'}")
    print("-" * 45)
    for ip, mac in entries:
        print(f"{ip:<20} {mac}")
    print("-" * 45)
    print("Total entries:", len(entries))
    # log the result
    log("ARP", "Scan complete - Total entries: " + str(len(entries)))
    # save to csv
    save_arp_csv(entries)

#saves results to text file
def save_to_file(entries):
    filename = "arp_results.txt"
    try:
       with open(filename, 'w') as f:
           f.write("ARP SCAN RESULTS")
           f.write("-" * 45 + "\n")
           for ip, mac in entries:
               f.write(f"{ip:<20} {mac}\n")
       print("results saved to", filename)
    except Exception as e:
       print("Could not save file ", str(e))

#main block 
def main():
     print("-------ARP SCANNER-------")
     print("System : ", platform.system())
     print("\n Scanning ARP table...... ")
     output = get_arp_table()
     if output is None:
         print("failed to get ARP table.EXITING......")
         sys.exit(1)

     entries = parse_arp_output(output)
     display_results(entries)
     save = input("Save results to text file ????????  (y/n): ").strip().lower()
     if save == 'y':
        save_to_file(entries)

if __name__ == "__main__":
     main()
