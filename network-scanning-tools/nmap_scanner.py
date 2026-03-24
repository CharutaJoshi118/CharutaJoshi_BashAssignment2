# importing required modules
import subprocess
import platform
import sys
from logger import log
from csv_export import save_nmap_csv

#check if nmap is installed or no before running
def check_nmap():
    try:
        res = subprocess.run(['nmap', '--version'], stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)
        if res.returncode == 0:
            print("NMAP is installed :", res.stdout.splitlines()[0])
            return True
        else:
            print("NMAP not found in the system")
            return False
    except FileNotFoundError:
        print("NMAP is not installed. PLease install it first before running.....")
        return False
    except Exception as e:
        print("Error:", str(e))
        return False

#this function builds and runs the nmap command
def run_map(target, flags, timeout=60):
    cmd = ['nmap'] + flags + [target]
    print("\n Running : ", ' '.join(cmd))
    print("\n Scanning...... this may take a while")
    try:
        res = subprocess.run(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True, timeout=timeout)
        if res.returncode == 0:
           return True, res.stdout
        else:
           return False, res.stderr
    except subprocess.TimeoutExpired:
       return False, "Scan timed out"
    except Exception as e:
       return False, str(e)

#prints the scan output to terminal
def show_results(output, target):
    print("\n Scan Done!!!!!")
    print("=" * 40)
    print(output)
    print("=" * 40)
    log("NMAP", "Scan completed on " + target)
    save_nmap_csv(target, output)

#this function saves raw o/p into text file
def save_to_file(output):
    fname = "nmap_results.txt"
    try:
       with open(fname, 'w') as f:
          f.write(output)
       print("Saved to", fname)
    except Exception as e:
       print("could not save : ", str(e))

#it shows the scan menu
def show_menu():
    print("\nSelect scan type:")
    print("1. Basic Host Discovery (-sn)")
    print("2. Port Scan (1-1000)")
    print("3. Custom Port Range")
    print("4. Service Version Detection (-sV)")
    print("5. OS Detection (-O)")
    choice = input("\nEnter choice (1-5): ").strip()
    return choice

# returns nmap flags based on user choice
def get_flags(choice):
    if choice == '1':
        return ['-sn']
    elif choice == '2':
        return ['-p', '1-1000']
    elif choice == '3':
        ports = input("Enter port range (e.g. 1-500): ").strip()
        return ['-p', ports]
    elif choice == '4':
        return ['-sV']
    elif choice == '5':
        # needs sudo to work
        print("Note: OS detection needs sudo")
        return ['-O']
    else:
        print("Wrong choice, using default port scan")
        return ['-p', '1-1000']
#main block
def main():
  print("-------NMAP SCANNER------")
  print("System:", platform.system())
  #check nmap 
  if not check_nmap():
       print("Install nmap first and run the code again")
       sys.exit(1)
  target = input("\n Enter target IP address or network :").strip()
  if not target:
     print("NO target given.Exiting.......")
     sys.exit(1)

  choice = show_menu()
  flags = get_flags(choice)
  ok, output = run_map(target, flags)
  if ok:
      show_results(output, target)
      ans = input("save results to file?????? (y/n) : ").strip().lower()
      if ans == 'y':
         save_to_file(output)
  else:
      print("Scan failed : ", output)

if __name__ == "__main__":
     main()

