#!/bin/bash

red='\033[31m'
green='\033[32m'
yellow='\033[33m'
NC='\033[0m'

if [ $# -eq 0 ]
then
    echo -e  "${green}Enter log file name :${NC}"
    exit
fi

filename=$1

#check for file existance
if [ ! -f "$filename" ]
then
    echo -e "${red}File not found${NC}"
    exit
fi

echo ""
echo -e "${yellow}=======LOG FILE ANALYSIS==========${NC}"
echo "Log File : $filename"

#total entries
echo ""
echo -e "${green}Total Entries :${NC} "
wc -l <  "$filename"

#unique IP address
echo ""
echo -e "${green}Unique IP Addresses :${NC}"
awk '{print $1}' "$filename" | sort | uniq

#Status code summary
echo ""
echo -e "${green}Status Code summary :${NC} "
awk '{print $NF}' "$filename" | sort | uniq -c | while read count code
do
    echo  "$code : $count requests"
done

#Most accessed
echo ""
echo -e "${green}Most accessed page${NC}"
awk '{print $7}' "$filename" | tr -d '"' | sort | uniq -c  | sort -nr | head -n 1 |   while read count page
do
   echo " $page : $count requests "
done

#Top 3 IP Addresses
echo ""
echo -e "${green}Top 3 IP addresses :${NC}"
awk '{print $1}' "$filename" | sort | uniq -c | sort -nr | head -3

#Date reange Analysis
echo ""
echo -e " ${yellow} Data Range Filter  ${NC}   "
echo -e "${green}Enter date : ${NC}"
read udate

echo -e "${green}Entries on that date :${NC}"
grep "$udate" "$filename"

#Security Threat Detection
echo ""
echo -e "${yellow}    Suspicious Activities ${NC}"
awk '$NF==403 {print $1}' "$filename" | sort | uniq -c |while read count ip
do
  if [ "$count" -gt 2 ]
  then
      echo "possible attacker IP : $ip (403 errors: $count)"
  fi
done


#generate csv report
echo ""
echo -e "${yellow} Creating CSV Report  ${NC}"

echo "IP,Requests" > report.csv
awk '{print $1}' "$filename" | sort | uniq -c | while read count ip
do
  echo "$ip,$count" >> report.csv
done
