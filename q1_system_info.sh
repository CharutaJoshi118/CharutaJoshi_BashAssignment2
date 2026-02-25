#!/bin/bash
Red='\033[31m'
Green='\033[32m'
Blue='\033[34m'
NC='\033[0m'


user=$(whoami)
host=$(hostname)
date=$(date)
osname=$(uname -s)
current_working_directory=$(pwd)
home_directory=$HOME
Number_of_users_logged_in=$(who | wc -l)
System_uptime=$(uptime)

echo "========================================="
echo -e  " ${Blue}System Information Display${NC}  "
echo -e  "${Green}Username            :${NC}$user"
echo -e  "${Green}Hostname            :${NC}$host"
echo -e  "${Green}Date & Time         :${NC}$date"
echo -e  "${Green}OS                  :${NC}$osname"
echo -e  "${Green}Current Dir         :${NC}$current_working_directory"
echo -e  "${Green}Home Dir            :${NC}$home_directory"
echo -e  "${Green}Users Online        :${NC}$Number_of_users_logged_in"
echo -e  "${Green}Uptime              :${NC}$System_uptime"
echo "========================================="

echo  ""
echo -e  "${Red}Disk usage :"
df -h /

echo ""
echo -e  "${Red}Memory usage :"
free -h



