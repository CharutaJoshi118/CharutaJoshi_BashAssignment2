import csv
import datetime

def save_ping_csv(results):
    fname = "ping_results.csv"
    with open(fname, "w", newline="") as f:
      writer = csv.writer(f)
      writer.writerow(["Host", "Status", "Avg time", "Timestamp"])
      for host, status,avg in results:
          timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
          writer.writerow([host, status, avg, timestamp])
    print("results saved to : ",fname)

def save_arp_csv(entries):
    fname = "arp_results.csv"
    with open(fname, "w", newline="") as f:
      writer = csv.writer(f)
      writer.writerow(["Host", "Status", "Avg time", "Timestamp"])
      for ip, mac in entries:
          timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
          writer.writerow([ip, mac, timestamp])
    print("ARP output stored in :",fname)

def save_nmap_csv(target, output):
    fname = "nmap_results.csv"
    with open(fname, "w", newline="") as f:
      writer = csv.writer(f)
      writer.writerow(["Target", "Scan Output", "Timestamp"])
      timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
      writer.writerow([target, output.strip(), timestamp])

    print("NMAP output saved in :",fname)

