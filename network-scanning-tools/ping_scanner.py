# importing required modules
import subprocess
import platform
import re
import sys
from logger import log
from csv_export import save_ping_csv

# runs ping command, different for windows and linux
def ping_host(host, count=4):
    os_type = platform.system().lower()
    # windows uses -n, linux uses -c for packet count
    if os_type == 'windows':
        command = ['ping', '-n', str(count), host]
    else:
        command = ['ping', '-c', str(count), host]
    try:
        # capture output so we can read it
        result = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=15)
        # 0 means success
        return result.returncode == 0, result.stdout
    except subprocess.TimeoutExpired:
        return False, "Request timed out"
    except Exception as e:
        return False, str(e)

#gets average ping time from o/p 
def get_avg_time(output):
    #windows format
    match = re.search(r'average = (\d+)ms', output, re.IGNORECASE)
    if match:
        return match.group(1) + "ms"
    #linux format
    match = re.search(r'[\d.]+/([\d.]+)/[\d.]+/[\d.]+ ms', output)
    if match:
        return match.group(1) + "ms"
    return "N/A"


#pings a host and prints result
def scan_single(host, count):
    print("\nPinging....", host, ".....")
    success, output = ping_host(host, count)
    avg = get_avg_time(output) if success else "N/A"
    status = "reachable" if success else "unreachable or invalid input"
    print("HOST       :", host)
    print("STATUS     :", status)
    print("AVERAGE TIME:", avg)

#save the result to log file
    log("PING", host + "-" + status + "-" + avg)

#ping multiple hosts and print the results with a summary table
def scan_multi(hosts, count):
    results = []
    for host in hosts:
        print("\n PINGING......", host, ".....")
        success, output = ping_host(host, count)
        avg = get_avg_time(output) if success else "N/A"
        status = "Reachable" if success else "Unreachable or invalid input"
        results.append((host, status, avg))
        print("status:", status, "| Average time:", avg)
#print summary table
    print("-------SUMMARY TABLE---------")
    print(f"{'HOST':<20} {'STATUS':<15} {'AVG time'}")
    print("-" * 45)
    for host, status, avg in results:
        print(f"{host:<20} {status:<15} {avg}")
    print("-" * 45)
    print("total hosts scanned are : ",len(results))

#export the results to csv file
    save_ping_csv(results)

#main
def main():
   print("-------PING SCANNER--------")
   print("System is :", platform.system())
   choice = input("\n Scan for singlr or multiple hosts?????? (s/m) :").strip().lower()
   if choice == 's':
       host = input("Enter the hostname or IP address :").strip()
       if not host:
           print("no host entered. EXITING......")
           sys.exit(1)
       count = input("Number of packets (default 4): ").strip()
       count = int(count) if count.isdigit() else 4
       scan_single(host, count)
   elif choice == "m":
       print("Enter hosts one by one.Once all the hosts are entered , type done. :")
       hosts = []
       while True:
           h = input("Host: ").strip()
           if h.lower() == 'done':
               break
           if h:
               hosts.append(h)
       if not hosts:
           print("No hosts entered. Exiting......")
           sys.exit(1)
       count = input("NUmber of packets per host(default 4): ").strip()
       count = int(count) if count.isdigit() else 4
       scan_multi(hosts, count)
   else :
      print("Invalid choice")
      sys.exit(1)


if __name__ == "__main__":
      main()

