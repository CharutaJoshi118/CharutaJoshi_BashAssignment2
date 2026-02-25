# Bash Scripting Assignment – README

**Name:** Charuta Joshi
**Course:** CampusPe  Cybersecurity – Bash Scripting
**Questions Attempted:** Q1, Q2, Q3, Q4, Q5 (All five)

---

## What This Assignment Is About

This assignment gave me hands-on experience with bash scripting for Linux system administration and cybersecurity automation. Over the course of five questions, I built scripts that do things like monitor system health, manage files through a menu, analyze web server logs, automate backups, and generate user account reports — tasks that real sysadmins and SOC analysts deal with every day.

It was challenging at times (more on that below), but I learned a lot along the way.

---

## How to Run the Scripts

> **First time only — make all scripts executable:**
> ```bash
> chmod +x *.sh
> ```

---

### Q1 – System Information Script
```bash
./Q1_System_information.sh
```
Displays a quick snapshot of the system: username, hostname, current date/time, OS details, home directory, logged-in users, disk usage, and memory usage. Good for getting your bearings on any Linux machine.

---

### Q2 – File & Directory Manager
```bash
./Q2_File_Manager.sh
```
A menu-driven script where you pick an option by number:
1. List files
2. Create directory
3. Create file
4. Delete file
5. Rename file
6. Search for a file
7. Count files & directories
8. View file permissions
9. Copy a file

---

### Q3 – Log Analyzer
```bash
./Q3_Log_analyzer.sh access.log
```
To test error handling with a missing file:
```bash
./Q3_Log_analyzer.sh wrong.log
```
Parses an Apache access log and reports: total requests, unique IPs, the most active IP, 404 errors, suspicious 403 attempts, and saves a CSV summary report.

---

### Q4 – Backup Automation Script

First, set up a test folder:
```bash
mkdir test_backup
touch test_backup/file{1..5}.txt
```
Then run:
```bash
./Q4_Backup.sh
```
The script takes a source and destination path, creates a compressed `.tar.gz` backup, keeps only the last 5 backups (auto-deletes older ones), logs everything to `backup.log`, and shows you the backup size and time taken.

---

### Q5 – User Account Reporter
```bash
sudo ./Q5_User_report.sh
```
Generates a full user report: total users, system vs regular users, currently logged-in users, a detailed table with UID/home/shell info, group memberships, UID 0 (root) users, inactive accounts, password expiry info, an HTML report, and a simulated email file.

To open the HTML report:
```bash
xdg-open user_report.html
```

---

## Sample Test Cases I Ran

**Q1:** Checked that disk usage and memory output displayed correctly on my Kali setup.

**Q2:** Created a directory called "RAM", made and deleted a file, renamed "ca" to "ram", and tested the copy and permission viewer options.

**Q3:** Ran on the provided `access.log` and also deliberately passed a non-existent filename to verify the error handling worked.

**Q4:** Created the `test_backup` folder, ran the script several times, and confirmed that only the 5 most recent backups were kept under `/home/kali/backup`.

**Q5:** Ran with `sudo`, opened the generated HTML report in the browser, and verified it correctly flagged inactive users and listed group memberships.

---

## Challenges I Faced (Honest Account)

A few things tripped me up during this assignment:

- **Forgot `chmod +x` initially** — scripts wouldn't run until I made them executable.
- **`lastlog` was missing on Kali** — had to work around this for the user reporter.
- **Backup rotation wasn't working at first** — the old files weren't being deleted; took some debugging to fix the logic.
- **Email sending wasn't possible** without an SMTP server, so I simulated it by writing output to `sent_mail.txt` instead.
- **Q4 was skipping prompts** due to an input redirection issue — took a while to figure out.
- **Path issues came up multiple times** across different scripts, especially when running from different directories.

Each of these bugs taught me something, which I think is the point of the assignment.

---

## What I Took Away From This

Working through these five scripts genuinely helped me understand how Linux administration works under the hood. Tools like `awk`, `grep`, `cut`, and `wc` went from being things I'd heard of to tools I actually used and understood. I also got a much clearer picture of why file permissions matter, and how automation makes security tasks scalable.

The log analysis and user auditing scripts in particular felt very relevant to SOC work — it's easy to see how these could be adapted for real monitoring tasks.

---

## Conclusion

This assignment was a solid introduction to practical bash scripting. It pushed me to think like a system administrator, debug real problems, and write scripts that actually do something useful. I'm walking away with a much stronger foundation in Linux automation and a better appreciation for how cybersecurity professionals use scripting in their daily work.
