#!/bin/bash
red='\033[31m'
green='\033[32m'
yellow='\033[33m'
NC='\033[0m'

echo -e "${red}======Automated Backup Script========${NC}"

echo -e "${green}Enter directory to backup :${NC} "
read src

if [ ! -d "$src" ]; then
  echo "Source directory not found"
  exit
fi

echo -e "${green}Enter backup destination path : ${NC}"
read dest

#create desti if not exists
mkdir -p "$dest"

echo " Select Backup Type :"
echo "1. Simple Copy "
echo "2. Compressed Archive"
echo -n "Enter choice :"
read choice

echo ""
echo "starting backup.... "
echo "Source :$src"
echo "Destination :$dest"

time_stamp=$(date +"%Y%m%d_%H%M%S")
name="backup_$time_stamp"

start=$(date +%s)

if [ "$choice" -eq 1 ]; then
  cp -r "$src" "$dest/$name"
  backup_path="$dest/$name"

elif [ "$choice" -eq 2 ]; then
  tar -czf "$dest/$name.tar.gz" "$src"
  backup_path="$dest/$name.tar.gz"

else
  echo " Invalid option "
  exit
fi

end=$(date +%s)
duration=$((end-start))

echo ""
echo "backup completed!!!"
echo ""
echo "Backup Details :"
echo "File : $(basename $backup_path)"
echo "location : $dest"
echo -n "size : "
du -sh "$backup_path" | cut -f1
echo "time taken : $duration seconds"

logfile="$dest/backup.log"

echo "   " >> "$logfile"
echo "Date :$(date)" >> "$logfile" 
echo "file :$backupfile" >> "$logfile"
echo "location :$dest" >> "$logfile"
echo "size: $size"  >> "$logfile"
echo "duration: $duration seconds" >> "$logfile"

echo ""
echo "Checking old backup......"
cd "$dest" || exit

count=$(ls backup_*.tar.gz 2>/dev/null | wc -l)

if [ "$count" -gt 5 ]; then
    echo "Removing old backups (keep last 5)..."
    ls -t backup_*.tar.gz | tail -n +6 | while read file
    do
        rm -f "$file"
        echo "Deleted: $file"
        echo "Deleted: $file on $(date)" >> "$logfile"
    done
else
    echo "No old backups to remove."
fi

# EMAIL NOTIFICATION 
echo ""
echo "Backup notification:"
echo "Backup completed successfully on $(date)"
