#!/bin/bash
red='\033[31m'
green='\033[32m'
yellow='\033[33m'
NC='\033[0m'

echo -e "${red}========USER REPORT============${NC}"
echo""

total_users=$(cat /etc/passwd | wc -l)
syst_user=$(awk -F: '$3 < 1000 {print $1}' /etc/passwd | wc -l)
regu_user=$(awk -F: '$3 >= 1000 {print $1}' /etc/passwd | wc -l)
logged_in=$(who | wc -l)


echo -e "${green}-----USER STATISTICS---------${NC}"
echo    "Total users                   : $total_users"
echo    "Total System users (UID<1000) : $syst_user"
echo    "Total Regular users (UID>=1000) : $regu_user"
echo    "Users currently logged in       : $logged_in"
echo ""


echo -e "${green}-----USER DETAILS TABLE---------${NC}"
printf "%-15s %-8s %-20s %-15s  %-20s\n" "Username" "UID" "Home Directory" "Shell" "Last Login" 

awk -F: '$3>=1000 && $1!="nobody" {print $1,$3,$6,$7}'  /etc/passwd | while IFS=: read user uid home shell
do
    last_login=$(last -n 1 $user 2>/dev/null | head -1 | awk '{print $4,$5,$6,$7,$8}')
    if [[ "$last_login" == "" || "$last_login" == "wtmp begins"* ]]; then
        last_login="Never"
    fi
    printf "%-15s %-6s %-20s %-15s %-20s\n" "$user" "$uid" "$home" "$shell" "$last_login"
done
echo ""


echo -e "${green}-----GROUP INFORMATION---------${NC}"
cut -d: -f1 /etc/group | while read grp
do
   count=$(grep "^$grp:" /etc/group | awk -F: '{print $4}' | tr ',' '\n' | grep -v '^$' | wc -l)
   echo "Group: $grp -> Members : $count"
done 

echo ""


echo -e "${green}-----SECURITY CHECKS---------${NC}"
echo -e "${yellow}Users with root privilege  (UID 0) :${NC} "
awk -F : '$3==0 {print $1}' /etc/passwd

echo -e  "${yellow}Users without passwords : ${NC}"
awk -F : '($2=="!" || $2=="*") {print $1}' /etc/shadow 2>/dev/null

echo ""

echo -e  "${yellow}Inactive users (never logged in) : ${NC}"
awk -F : '$3>=1000 {print $1}' /etc/passwd | while read user
do
   last $user |grep -q "$user"
   if [ $? -ne 0 ]; then 
        echo "$user"
   fi
done 





HTML_FILE="user_report.html"

echo "Generating HTML report..."

total_users=$(wc -l < /etc/passwd)
system_users=$(awk -F: '$3<1000 {count++} END{print count}' /etc/passwd)
regular_users=$(awk -F: '$3>=1000 {count++} END{print count}' /etc/passwd)
logged_in=$(who | wc -l)

cat <<EOF > $HTML_FILE
<html>
<head>
<title>User Report</title>
<style>
body { font-family: Arial; background-color:#f4f4f4; }
h1 { color: darkblue; }
table { border-collapse: collapse; width: 80%; }
th, td { border:1px solid black; padding:6px; }
th { background-color: lightgray; }
</style>
</head>
<body>

<h1>User Account Report</h1>

<ul>
<li>Total Users: $total_users</li>
<li>System Users: $system_users</li>
<li>Regular Users: $regular_users</li>
<li>Currently Logged In: $logged_in</li>
</ul>

<table>
<tr>
<th>Username</th>
<th>UID</th>
<th>Password Expiry</th>
</tr>
EOF

awk -F: '$3>=1000 {print $1,$3}' /etc/passwd | while read user uid
do
    expiry=$(chage -l $user 2>/dev/null | grep "Password expires" | cut -d: -f2)
    if [ -z "$expiry" ]; then
        expiry="Not set"
    fi

    echo "<tr><td>$user</td><td>$uid</td><td>$expiry</td></tr>" >> $HTML_FILE
done

cat <<EOF >> $HTML_FILE
</table>

<h2>User Distribution Graph</h2>
<div style="background:blue;width:${total_users}px;height:20px;"></div>
<div style="background:red;width:${system_users}px;height:20px;"></div>
<div style="background:green;width:${regular_users}px;height:20px;"></div>

</body>
</html>
EOF

echo "HTML report saved as $HTML_FILE"



read -p "Do you want to email the report? (y/n): " choice
if [ "$choice" = "y" ]; then
    read -p "Enter email address: " email
    echo "Sending report to $email ..."
    echo "Subject: User Report" > sent_mail.txt
    echo "To: $email" >> sent_mail.txt
    echo "Attachment: $HTML_FILE" >> sent_mail.txt
    echo "Report generated on: $(date)" >> sent_mail.txt
    echo "Email simulation complete. Check sent_mail.txt file."
fi

