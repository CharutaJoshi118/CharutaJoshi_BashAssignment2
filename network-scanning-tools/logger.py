import datetime

def log(tool, message):
    timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S ")
    log_entry = "[" + timestamp +"] [" + tool + "]" + message + "\n"
    print(log_entry.strip())
    with open("scan_log.txt", "a") as f:
       f.write(log_entry)
