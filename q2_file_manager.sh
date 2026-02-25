#!/bin/bash

Red='\033[31m'
Yellow='\033[33m'
Blue='\033[34m'
NC='\033[0m'
while true
do

echo ""
echo -e "${Red}FILE & DIRECTORY MANAGER ${NC}     "
echo "1.List files in current directory      "
echo "2.Create a new Directory               "
echo "3.Create a new file                    "
echo "4.Delete a file                        "
echo "5.Rename a file                        "
echo "6.Search for a file                    "
echo "7.Count files and directories          "
echo "8.View File Permission                 "
echo "9.Copy a file                          "
echo "10.Exit                                "

echo -n "enter choice :"
read ch

case $ch in
1)  echo -e  "${Blue}File present :${NC}"
    ls -lh
    ;;


2)  echo -e  "${Blue}Directory name ???${NC}"
    read dirname

    if [ -d "$dirname" ]
    then
      echo -e "${Yellow}Directory already exists${NC}"
    else 
      mkdir "$dirname"
      echo -e  "${Yellow}Directory created${NC}"
    fi
    ;;

3)  echo -e "${Blue}File name :${NC} "
    read filename 

    if [ -f "$filename" ]
    then
         echo -e "${Yellow}File already exists${NC} "
    else 
          touch "$filename"
          echo -e "${Yellow}File created${NC}"
   fi
   ;;

4) echo -e "${Blue}Enter the file to delete :${NC}"
   read filename
  
   if [ -f "$filename" ]
   then
        echo -e "${Yellow} Sure Delete it???? y/n ${NC}"
        read answer
        if [ "$answer" = "y" ]
        then
             rm "$filename"
             echo -e "${Yellow}File Deleted${NC}"
        else 
        echo -e  "${Yellow}File not deleted${NC}"
        fi
    else
        echo -e "${Yellow}No such file exists${NC}"
    fi
    ;;


5) echo -e  "${Blue}Old name of the file :${NC}"
   read old
   echo -e  "${Blue}New name of the file :${NC}"
   read new

   if [ -f "$old" ]
   then
       mv "$old" "$new"
       echo -e "${Yellow}File is renamed${NC}"
   else
       echo -e "${Yellow}File is missing${NC}"
   fi
   ;;


6) echo -e "${Blue}Enter the name to search :${NC}"
   read name 
   find . -name "$name"
   ;;

7) echo -e "${Blue}Total files :${NC}"
   find . -type f | wc -l
   echo -e "${Yellow}Total directories :${NC}"
   find . -type d | wc -l
   ;;

8)  echo -e "${Blue}Enter file name :${NC}"
    read filename
    if [ -e "$filename" ]
    then 
        echo -e "${Yellow}Permissions are :${NC}"
        ls -l "$filename"
    else
        echo -e  "${Yellow}File not found${NC}"
    fi
    ;;

9)  echo -e "${Blue}Enter the source file :${NC}"
    read src
    
   if [ -f "$src" ]
   then
       echo -e "${Yellow}Enter destination file name :${NC}"
       read desti
       cp "$src" "$desti"
       echo -e "${Yellow}File Copied${NC}"
   else
       echo -e "${Yellow}File not copied${NC}"
   fi
   ;;


10) echo -e "${Blue}Exiting...${NC}"
    break
    ;;


*)  echo -e  "${Blue}Invalid choice${NC}"
    ;;

esac
done
