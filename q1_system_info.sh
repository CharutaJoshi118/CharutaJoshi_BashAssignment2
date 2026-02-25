#!/bin/bash

# Color codes for making output look good
Red='\033[31m'
Green='\033[32m'
Blue='\033[34m'
NC='\033[0m'  #NC means no colour

user=$(whoami)     #gets user name	
host=$(hostname)   #gets machine name
date=$(date)       #gets current date and time
osname=$(uname -s) #gets operating syst name
current_working_directory=$(pwd)  #gets current directory path
home_directory=$HOME  #gets home directory
Number_of_users_logged_in=$(who | wc -l) ##counts users 
System_uptime=$(uptime) #shows how long the syst is up


#Displays all the info
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

#shows disk usage
echo  ""
echo -e  "${Red}Disk usage :"
df -h /

#shows memory usage
echo ""
echo -e  "${Red}Memory usage :"
free -h



