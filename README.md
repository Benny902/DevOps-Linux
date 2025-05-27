# DevOps-Linux
<br />

<details>
<summary>Week 1 Tasks – Intro to DevOps & Linux</summary>
<br />

## 1. Basic Linux Commands

```bash
# Basic commands to Navigate and manage directories

pwd                   # Print current directory
ls                    # List contents of the directory
mkdir devops_test     # Create new directory
cd devops_test        # Change to that directory
touch testfile.txt    # Create a test file
rm testfile.txt       # Delete the test file
cd ..                 # Go back one directory (can also do cd ../../ and etc)
rm -r devops_test     # Delete the directory
```

## 2. Create Users and Assign to Custom Group

```bash
# Create a new group
sudo groupadd devopsteam

# Create users and assign them to the group
sudo useradd -m -G devopsteam user1
sudo useradd -m -G devopsteam user2

# Verify group membership
groups user1
groups user2
```

## 3. Change File and Directory Permissions

```bash
# Create a directory and a file
mkdir /tmp/secure_folder
touch /tmp/secure_folder/groupfile.txt

# Change ownership to a user and group
sudo chown user1:devopsteam /tmp/secure_folder/groupfile.txt

# Change permissions to allow group read/write
sudo chmod 660 /tmp/secure_folder/groupfile.txt

# Verify permissions
ls -l /tmp/secure_folder/groupfile.txt
```

</details>

******

<details>
<summary>Week 1 Summary Task – DevOps & Linux Basics</summary>
<br />

## Part 1: Creating Directory Structure & Permissions

```bash
# Create base project directory in user's home directory
mkdir -p ~/project1/docs ~/project1/scripts

# Set permissions
chmod 744 ~/project1/scripts  # Owner: rwx, Group/Others: r--
chmod 777 ~/project1/docs     # Everyone: rwx (write access for all users)
```

## Part 2: User & Group Management

```bash
# Create user and group
sudo groupadd devteam
sudo useradd -m -G devteam devuser

# Set 'project1' ownership to your user and give group read-only access
sudo chown $USER:devteam ~/project1
chmod 740 ~/project1  # Owner: rwx, Group: r--, Others: ---
```

## Part 3: Verification Commands

```bash
# Show final directory structure and permissions
ls -lR ~/project1

# Show group membership for devuser
groups devuser
```
Screenshot of the outcome:  
![alt text](images/image.png)
## Command Explanations

- `mkdir -p`: Creates directories; `-p` ensures parent directories are made as needed.
- `chmod 744`: Sets file/directory permissions (`7`=rwx, `4`=r--).
- `chmod 777`: Gives full read/write/execute permissions to all.
- `groupadd`: Adds a new group to the system.
- `useradd -m -G`: Creates a user with a home directory and adds them to a group.
- `chown`: Changes ownership of a file or directory.
- `ls -lR`: Recursively lists directory contents with permissions.
- `groups`: Shows all groups a user belongs to.

> When we use `$USER` it becomes the current username (in my case Benny06nov21).

> We can use 'whoami' to confirm the current username:

</details>

******

<details>
<summary>Week 2 Tasks – Daily Practice Tasks</summary>
<br />

## Task 1: Hello DevOps Script

### Create the Script file `hello_devops.sh`

```bash
nano hello_devops.sh
```

### now we are in the file with nano editor, we can write the script:
```bash
#!/bin/bash
echo "Hello DevOps"
```
* to save press CTRL+O and then press enter.
* then to exit the nano press CTRL+X
* `#!/bin/bash`: Tells the system to use the Bash shell to run this script.

### Make Executable and Run:
```bash
chmod +x hello_devops.sh
./hello_devops.sh
```

---

## Task 2: File & Directory Checker

### Create the Script file same way as in first task: `check_file.sh`
```bash
#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: ./check_file.sh <filename>"
  exit 1
fi

if [ -f "$1" ]; then
  echo "$1 is a file."
elif [ -d "$1" ]; then
  echo "$1 is a directory."
else
  echo "$1 does not exist."
fi
```
- `$1`: is the first argument passed to the script.
- `-z`: checks if it's an empty string.
- `-f`: checks if a file exists and is a regular file.
- `-d`: checks if the path is a directory.

### Make Executable and Run:
```bash
chmod +x check_file.sh
./check_file.sh hello_devops.sh
```

---

## Task 3: List Files with Sizes

### Create the Script file same way as previous tasks: `list_files.sh`
```bash
#!/bin/bash

printf "%-30s %-10s\n" "Filename" "Size (KB)"
printf "%-30s %-10s\n" "--------" "----------"

for file in *; do
  if [ -f "$file" ]; then
    size=$(du -k "$file" | cut -f1)
    printf "%-30s %-10s\n" "$file" "$size"
  fi
done
```
- `printf "%-30s %-10s\n"`: Prints a formatted line with two columns:
    - %-30s → left-align string to 30 characters (for filename)
    - %-10s → left-align string to 10 characters (for file size)
    - The first two printf lines print the header and underline for the table.
- for file in *: Loops over all items in the current directory (files and folders).
- if [ -f "$file" ]; then: Checks if the item is a regular file (ignores folders).
    - du -k "$file":
    - du = disk usage
- -k = show size in kilobytes (KB)
- `cut -f1`: Cuts the first column of the du output (the size number).
- `size=$(...)`: Stores the file size into a variable called size.
- `printf ... "$file" "$size"`: Prints a row of the table with the filename and its size.

### Make Executable and Run:
```bash
chmod +x list_files.sh
./list_files.sh
```

---

## Task 4: Search for ERROR Logs

### Create a file for testing the script: `access.log`
```bash
cat > access.log << EOF
this is the first line
this is 2nd line with ERROR 
this is ERROR line 
this line has ERROR also
this ERROR line has two ERROR
EOF
```
- total ERROR count is 5, but there 4 lines with ERROR, i will demonstrate the difference below.

### Create the Script file with nano: `find_errors.sh`
```bash
#!/bin/bash

echo "Lines with ERROR:"
grep "ERROR" access.log

echo "Wrong ERROR count:"
grep -c "ERROR" access.log

echo "Correct ERROR count:"
grep -o "ERROR" access.log | wc -l
```
- if using `grep -c "ERROR" access.log` it will return '4' which is incorrect because `-c` Counts matching lines.
- if using `grep -o "ERROR" access.log | wc -l` it will return '5' which is the correct answer because:
    - `-o`: Only print matching parts
    - and then we pipe the result and use `wc -l` to count total matches

### Make Executable and Run::
```bash
chmod +x find_errors.sh
./find_errors.sh
```

---

## Task 5: AWK Column Extractor

### Create a file for testing the one-liner: `data.csv`
```bash
cat > data.csv << EOF
1,Benny,Developer
2,Shalom,Backend
3,Benjamin,DevOps
4,Bennyaaa,Linux
5,BennySh,SoftwareEngineer
EOF
```

### One-liner AWK for `data.csv`:
```bash
awk -F',' '{ print $2 }' data.csv
```

- `awk`: A text-processing tool.
- `-F','`: sets comma as the Separator (instead of the default: spaces).
- `{ print $2 }`: prints the second column.


</details>

******


<details>
<summary>Week 2 Summary Task – Advanced Log Report Automation</summary>
<br />

## Task Overview

creating a modular, user-friendly script that analyzes log files, generates a professional report, and supports dynamic input parameters.

---

## Detailed script with comments:
#### (the clean script file `advanced_log_report.sh` without commnets is in the 'week2_summary' folder)
```bash
#!/bin/bash

# Advanced Log Report Generator

# CONFIG
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_TXT="report_$TIMESTAMP.txt"
REPORT_CSV="report_$TIMESTAMP.csv"
KEYWORDS=()
LOG_DIR=""
START_TIME=$(date +%s.%N)
COLOR_ON=false
RECURSIVE=false

# print help when using the option '--help'
print_help() {
    echo "Usage: $0 <log_directory> [--keywords KEY1 KEY2 ...] [--recursive] [--color] [--help]"
    echo ""
    echo "Options:"
    echo "  --keywords    List of keywords to search for (for example, ERROR WARNING CRITICAL)"
    echo "  --recursive   Recursively scan all subdirectories"
    echo "  --color       Enable colored terminal output"
    echo "  --help        Display this help message"
    exit 0
}

show_spinner() {
    local filename="$1"
    local spinstr='|/-\\'
    local delay=0.1

    for i in {1..10}; do
        printf "\r[%c] Scanning: %s" "${spinstr:i%4:1}" "$filename" >&1
        sleep $delay
    done
    printf "\r[V] Scanning: %s\n" "$filename"
}

# parsing arguments
parse_args() {
    while [[ $# -gt 0 ]]; do # while still unchecked arguments (args>0)
        case "$1" in
            --keywords)
                shift
                while [[ $# -gt 0 && ! "$1" =~ ^-- ]]; do # while (keywords>0) and current argument ($1) does not start with --
                    KEYWORDS+=("$1") # add the current argument to the KEYWORDS array
                    shift # move to the next argument
                done
                ;;
            --recursive)
                RECURSIVE=true # set flag of recursive to true.
                shift
                ;;
            --color)
                COLOR_ON=true # set flag of color to true.
                shift
                ;;
            --help)
                print_help # calls the print_help function
                ;;
            -*)
                echo "Unknown flag: $1" # if anything else then the known args then exit with error.
                exit 1
                ;;
            *)
                LOG_DIR="$1" # set the log_dir to the first arg
                shift
                ;;
        esac
    done
}

validate_input() {
    if [[ -z "$LOG_DIR" ]]; then
        echo "Error: Log directory not provided."
        exit 1
    fi
    if [[ ! -d "$LOG_DIR" ]]; then
        echo "Error: '$LOG_DIR' is not a valid directory."
        exit 1
    fi
    if [[ ${#KEYWORDS[@]} -eq 0 ]]; then
        echo "Error: No keywords specified."
        exit 1
    fi
}

# Prints the header section for each log file in both TXT and CSV formats
print_header() {
    local filename
    filename=$(basename "$1") # extract just the filename from full path

    # Print formatted header to report.txt
    echo "Log File: $filename" | tee -a "$REPORT_TXT"
    echo "| Keyword     | Occurrences |" | tee -a "$REPORT_TXT"
    echo "|-------------|-------------|" | tee -a "$REPORT_TXT"

    # Write header to CSV
    echo "Log File: $filename" >> "$REPORT_CSV"
    echo "Keyword,Occurrences" >> "$REPORT_CSV"
}

# Prints a single row of keyword and count in both TXT and CSV formats
print_line() {
    local keyword=$1
    local count=$2

    if $COLOR_ON; then  # Print colorized line to terminal and append to report.txt
        printf "| \e[1;33m%-11s\e[0m | \e[1;36m%-11s\e[0m |\n" "$keyword" "$count" | tee -a "$REPORT_TXT"
    else                # Print plain text line and append to report.txt
        printf "| %-11s | %-11s |\n" "$keyword" "$count" | tee -a "$REPORT_TXT"
    fi

    # Write the same data to the CSV report
    echo "$keyword,$count" >> "$REPORT_CSV"
}
# \e[1;33m              - ANSI escape code to set bold yellow text
# %-11s                 - Left-align the string ($keyword and on the other $count) in an 11-character column
# \e[0m                 - Reset formatting (clear color/bold)
# \e[1;36m              - ANSI escape code to set bold cyan text
# tee -a "$REPORT_TXT"  - writes the output to both terminal (stdout) and appends (-a means "append", not overwrite) it to the file $REPORT_TXT


generate_report() {
    # Clear previous report files ('>' overwrites, '>>' appends — here we overwrite)
    echo "" > "$REPORT_TXT"
    echo "" > "$REPORT_CSV"
    
    local files
    # Determine which files to scan based on recursion flag
    if $RECURSIVE; then
        find "$LOG_DIR" -type f -name '*.log'
    else
        find "$LOG_DIR" -maxdepth 1 -type f -name '*.log'
    fi | while IFS= read -r file; do # Process each file found ### 'for' cannot safely handle filenames with spaces or newlines. we must use 'while'
        print_header "$file" # Write file section header

        # Count and write occurrences for each keyword
        for keyword in "${KEYWORDS[@]}"; do  # Loop through each keyword passed via --keywords
            count=$(grep -o "$keyword" "$file" 2>/dev/null | wc -l)  # Count how many times the keyword appears in the file
            print_line "$keyword" "$count"  # Print the result in table format and append to TXT/CSV
        done

        echo ""                     # New line to separate entries in terminal
        echo "" >> "$REPORT_TXT"    # New line in TXT report
        echo "" >> "$REPORT_CSV"    # New line in CSV report
    done
}
# wc -l         - counts how many matches
# 2>/dev/null   - silently suppress error messages from grep when:
## The file can’t be read (e.g., permission denied)
### The file is binary or corrupted
#### grep hits something unexpected and normally prints to stderr

# Calculates and prints the total script execution time
print_execution_time() {
    END_TIME=$(date +%s.%N)  # Capture current time with nanosecond precision
    DURATION=$(echo "$END_TIME - $START_TIME" | bc)  # Subtract start time from end time using bc for float math
    echo "Total Execution Time: ${DURATION} seconds" | tee -a "$REPORT_TXT"  # Print and append the duration to the report
}
# bc handles the subtraction with decimal precision, because Bash can’t subtract floats natively.

main() {
    parse_args "$@"
    validate_input
    generate_report
    print_execution_time
}

# '$@': all the command-line arguments, exactly as passed, preserving quotes.
main "$@"
```

### Key Features
- Accepts a log directory as input
- Supports `--keywords` flag with multiple terms ( `--keywords ERROR WARNING CRITICAL` )
- Recursively scans directories with `--recursive`
- Outputs results to `report.txt` and `report.csv`
- Includes total execution time
- Colored terminal output with `--color`
- Usage guide with `--help`
- Modular structure with clear functions and error handling

---

## Example Usage

```bash
chmod +x advanced_log_report.sh

# Basic usage
./advanced_log_report.sh ./logs --keywords ERROR WARNING CRITICAL

# Recursive search
./advanced_log_report.sh ./logs --keywords ERROR WARNING CRITICAL --recursive

# With color output
./advanced_log_report.sh ./logs --keywords ERROR WARNING CRITICAL --recursive --color

# Show help
./advanced_log_report.sh --help
```


### it will generate two files:
    - `report.txt`: Human-readable summary
    - `report.csv`: Machine-readable CSV format

### view them with cat (or open them manually):
```bash
cat report.txt
cat report.csv
```

</details>

******

<details>
<summary>Week 3 Tasks – Daily Practice Tasks</summary>
<br />

## Task 1: Basic IP & Port Exploration

```bash
ip a              # Show local IP addresses
ifconfig          # Alternate IP viewer (may require net-tools)

netstat -tuln     # List all listening ports (TCP/UDP)
ss -tuln          # Modern alternative to netstat
```

**Explanation of `127.0.0.1:22`:**  
127.0.0.1 this IP address is a loopback address that points to the computer, smartphone, or tablet you are using, and is also called localhost.  
Port 22 is dedicated to Secure Shell (SSH), which allows you to securely connect to a remote device and issue commands as if you were in front of it.

---

## Task 2: Generate SSH Key & Connect (+Task 3: Create Azure VM)

### Generate the SSH key:
```bash
ssh-keygen -t rsa -b 2048 -f ~/.ssh/id_rsa
```
and then presse 'enter' to accept the file location.  
and again press 'enter' two times to skip setting passphrase.

### Script to create an Azure Linux VM and Add this public key to the VM
```bash
#!/bin/bash

# Set variables
RESOURCE_GROUP="bennyVMeastus2"
LOCATION="eastus2" # cheapest for Standard_B1ls as i saw in pricing
VM_NAME="myvm"
ADMIN_USER="azureuser"

# Create resource group
az group create --name "$RESOURCE_GROUP" --location "$LOCATION"

# Create VM # Standard_B1ls is the cheapest.
az vm create \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --image Ubuntu2204 \
  --size Standard_B1ls \
  --admin-username "$ADMIN_USER" \
  --authentication-type ssh \
  --generate-ssh-keys

# Add the public key to the VM (from ~/.ssh/id_rsa.pub)
az vm user update \
  --resource-group "$RESOURCE_GROUP" \
  --name "$VM_NAME" \
  --username "$ADMIN_USER" \
  --ssh-key-value "$(cat ~/.ssh/id_rsa.pub)"

# Open SSH port 22 (if not already open)
az vm open-port --port 22 --resource-group "$RESOURCE_GROUP" --name "$VM_NAME"
```

### Run the Script:
```bash
chmod +x create_vm_and_add_public_key.sh
./create_vm_and_add_public_key.sh
```

### Connect to the Azure VM without password:
```bash
ssh azureuser@<vm-public-ip>
```

---


## Task 4: Remote File Transfer with SCP

```bash
# if we are connected to the azure, we need to 'exit' to return to the local wsl
exit 

# Upload file
scp myfile.txt azureuser@<vm-public-ip>:/home/azureuser/

# Download file back to a different local path
scp azureuser@<vm-public-ip>:/home/azureuser/myfile.txt myfile_copied.txt

```

---

## Task 5: Run a Remote Command via SSH

```bash
# Run commands remotely
ssh -t azureuser@<vm-public-ip> "uptime"
ssh -t azureuser@<vm-public-ip> "df -h"
ssh -t azureuser@<vm-public-ip> "ls -l /home/azureuser"

# Save output locally
ssh -t azureuser@<vm-public-ip> "df -h" > vm_disk_usage.txt
```

</details>

******

<details>
<summary>Week 3 Summary Task – Remote Log
Monitoring with SSH & VM </summary>
<br />

## Task Objective:
This task is designed to consolidate the skills learned throughout Week 3 and apply them
in a practical, real-world DevOps scenario. You will connect to a remote virtual machine
using SSH, retrieve log files, analyze them for critical patterns (e.g., ERROR,
WARNING), and produce professional reports in both human-readable TXT and CSV
formats. This exercise reinforces concepts from previous weeks—including Bash
scripting, keyword parsing, working with files, and now adds secure networking and
virtual infrastructure access.

## Before we start, need to make sure you can connect to the VM without password:
(further instructions are in 'week3 - Daily Practice Tasks' above)
```bash
ssh azureuser@<vm-public-ip>
```
* after verifying, now we can `exit`

## Now we send some logs to the VM:
Script: `upload_logs_to_vm.sh`:
```bash
#!/bin/bash

REMOTE="$1"
LOCAL_FOLDER="$2"
REMOTE_FOLDER="$3"

if [[ -z "$REMOTE" || -z "$LOCAL_FOLDER" || -z "$REMOTE_FOLDER" ]]; then
  echo "Usage: $0 <user@host> <local_folder> <remote_folder>"
  echo "Example: $0 azureuser@52.1.2.3 ./logs /home/azureuser/logs_target"
  exit 1
fi

if [[ ! -d "$LOCAL_FOLDER" ]]; then
  echo "Error: '$LOCAL_FOLDER' is not a valid local directory"
  exit 1
fi

# Strip trailing slash if present
LOCAL_FOLDER="${LOCAL_FOLDER%/}"

# Ensure remote folder exists
ssh "$REMOTE" "mkdir -p \"$REMOTE_FOLDER\""

echo "Uploading '$LOCAL_FOLDER/' to $REMOTE:$REMOTE_FOLDER ..."
rsync -avz --progress "$LOCAL_FOLDER/" "$REMOTE:$REMOTE_FOLDER/"

echo "Upload complete → $REMOTE:$REMOTE_FOLDER"
```
- `-a` archive mode: preserves permissions, timestamps, symbolic links, etc.

- `-v` verbose: prints what’s happening.

- `-z` compress: compresses file data during the transfer for efficiency.

- `--progress` shows real-time progress of file transfers.

- `"$LOCAL_FOLDER/"` Trailing slash means “copy contents of the folder” (not the folder itself).

- `"$REMOTE:$REMOTE_FOLDER/"` Specifies the remote user/host and destination directory.

### Usage:
```bash
chmod +x upload_logs_to_vm.sh
./upload_logs_to_vm.sh <user@host> <local_folder> <remote_folder>
```

## Example:
```bash
./upload_logs_to_vm.sh azureuser@13.68.110.243 ./logs_to_upload /home/azureuser/logs_in_remote
```

## Now we can get logs from the VM:
Script: `remote_wrapper.sh`:
```bash
#!/bin/bash

# Remote Wrapper for Local Log Analyzer
## Downloads log files from a remote server, extracts archives,
## and invokes the local advanced_log_report.sh analyzer script.

# CONFIG
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")  # Current timestamp for folder uniqueness
TMP_DIR="./tmp_logs_$TIMESTAMP"         # Temporary directory for downloaded/extracted logs
START_TIME=$(date +%s.%N)               # Start time for execution duration

# Print usage instructions
print_help() {
    echo "Usage: $0 <remote_user@host> <remote_log_dir> --keywords KEY1 [KEY2 ...] [--recursive] [--color]"
    echo ""
    echo "Positional arguments:"
    echo "  <remote_user@host>       Remote SSH login"
    echo "  <remote_log_dir>         Remote directory containing logs"
    echo ""
    echo "Options (passed to advanced_log_report.sh):"
    echo "  --keywords KEY1 [...]    Required keywords to search for"
    echo "  --recursive              Recursively scan subdirectories"
    echo "  --color                  Enable colored output"
    echo "  --help                   Show this help message"
    exit 1
}

# Validate argument count and check for --help flag
if [[ "$#" -lt 3 || "$1" == "--help" ]]; then # if args less than 3 or the first argument is --help
    print_help
fi

# Ensure required --keywords argument exists
if ! printf '%s\n' "$@" | grep -q -- "--keywords"; then
    echo "Error: Missing required --keywords argument."
    print_help
fi
# -q means “quiet” (no output, just sets exit code if found/not found), and when grep sees -- and stops treating further arguments as options.

# Extract and shift positional arguments
REMOTE_HOST="$1"       # Remote SSH login (e.g. user@host)
REMOTE_DIR="$2"        # Path to remote directory with logs
shift 2
PASSTHRU_ARGS=("$@")   # All remaining arguments passed to local analyzer

# Download logs and archives from the remote server
download_logs() {
    mkdir -p "$TMP_DIR"  # Create TMP_DIR if it doesn't exist (-p means no error if it exists)
    echo "[*] Downloading logs and archives..."
    
    # Run a remote 'find' via SSH: list all .log, .zip, .tar, .tar.gz files under REMOTE_DIR (escaped parentheses and quotes for correct remote parsing)
    ssh "$REMOTE_HOST" "find \"$REMOTE_DIR\" -type f \\( -iname '*.log' -o -iname '*.zip' -o -iname '*.tar' -o -iname '*.tar.gz' \\)" > /tmp/remote_log_list.txt # ">" overwrite if exists.

    # Read each line (remote file path) from the log list
    while IFS= read -r remote_file; do
        echo "[Downloading] $remote_file"
        # Try rsync for efficient copying:
        # -a (archive, preserves attributes), -v (verbose), -z (compress), --protect-args (handle spaces/special chars)
        # 2>/dev/null hides rsync errors (so script can fallback to scp)
        rsync -avz --protect-args "$REMOTE_HOST:$remote_file" "$TMP_DIR/" 2>/dev/null || \
        # If rsync fails (exit code not zero), use scp as fallback
        # -q (quiet), quotes protect spaces in remote path
        scp -q "$REMOTE_HOST:\"$remote_file\"" "$TMP_DIR/"
    done < /tmp/remote_log_list.txt
}
# Use rsync first for its efficiency (only transfers changes, can resume, preserves file attributes, handles spaces, and provides progress output).
# Fall back to scp for compatibility on systems where rsync is not installed or unavailable.

# Extract all supported archive types (.zip, .tar, .tar.gz)
extract_archives() {
    echo "[*] Extracting archives..."
    find "$TMP_DIR" -type f \( -iname "*.zip" -o -iname "*.tar" -o -iname "*.tar.gz" \) | while read -r archive; do
        case "$archive" in
            *.zip) unzip -q "$archive" -d "$TMP_DIR" ;; # in unzip -d is directory
            *.tar) tar -xf "$archive" -C "$TMP_DIR" ;; # but in tar its -C ## -x (extract), -f (archive file).
            *.tar.gz) tar -xzf "$archive" -C "$TMP_DIR" ;; # same here -C . ## -x (extract), -z (gzip support), -f (archive file).
        esac
    done
}

# Run the local analyzer script on the downloaded and extracted logs
run_local_analyzer() {
    echo "[*] Running local analyzer..."
    chmod +x ./advanced_log_report.sh
    ./advanced_log_report.sh "$TMP_DIR" "${PASSTHRU_ARGS[@]}"
}

# Main flow
main() {
    download_logs
    extract_archives
    run_local_analyzer
}

main
```
### Key Features
- Connects to a remote server via SSH (<user@host>)
- Accepts a remote log directory path as positional input
- Automatically downloads .log, .zip, .tar, and .tar.gz files
- Supports recursive scanning of subdirectories with --recursive
- Extracts archives locally before analysis
- Passes all flags (--keywords, --color, etc.) to the local analyzer (advanced_log_report.sh)
- Accepts --keywords with one or more terms (e.g. --keywords ERROR WARNING)
- Produces structured output: remote_report_*.txt and remote_report_*.csv (via delegated script)
- Displays execution progress with clear status messages and spinners
- Includes built-in --help with usage examples
- Modular function-based architecture for clean maintenance and extension


## Script Usage
```bash
sudo apt install unzip # the script uses unzip
chmod +x remote_wrapper.sh
./remote_wrapper.sh <remote_user@host> <remote_log_dir> [--keywords KEY1 KEY2 ...] [--recursive] [--color] [--help]
```

### Example:
```bash
./remote_wrapper.sh azureuser@13.68.110.243 /home/azureuser/logs_in_remote --keywords ERROR WARNING CRITICAL --recursive --color
```

</details>

******

<details>
<summary>Week 4 Tasks – Daily Practice Tasks </summary>
<br />

## Task 1: Branching & Switching
Initialize a new local Git repository:
```bash
git init
echo "# Week 4 Git Practice" > README.md
git add README.md
git commit -m "init"
```

Create two branches:
```bash
git checkout -b feature-a
git checkout -b feature-b
```

Switch between them:
```bash
git switch feature-a
# or
git checkout feature-a
```

Make a change on each branch and commit:
```bash
echo "Change for feature-a" >> file.txt
git add file.txt
git commit -m "Add feature-a change"
```

---

## Task 2: Simulate and Resolve Merge Conflicts
In both branches, edit the **same line** in `file.txt` to different content.

Merge one branch into the other and observe the conflict:
```bash
git checkout feature-a
git merge feature-b
```

Resolve the conflict manually in the editor or using:
```bash
git status
# Edit the file to fix conflicts
git add file.txt
git commit -m "Resolve merge conflict"
```
after `git add file.txt` and `git commit -m "Resolve merge conflict"` Git stores the resolved version and finalizes the merge.

---

## Task 3: Rebase and Cherry-Pick
before the rebase, we can view the log history by `git log --oneline`:
>$ git log --oneline  
>1605d5c (HEAD -> feature-a) Resolve merge conflict  
>97cdfc0 (feature-b) Add feature-a change  
>84a807b Add feature-a change  
>b4b7a66 (master) init  


Rebase `feature-a` onto `master`:
```bash
git checkout feature-a
git rebase master
```

if we have conflict we have few options:  
- we can resolve the conflict and then use `git rebase --continue` to continue with the rebase.
- we can skip the commit with the conflict it `git rebase --skip`.
- or we can abord the rebase with `git rebase --abort`.

i had conflict, so using the editor i made a combination of both features in the file.txt.  
and now to view the changes and the commit history log history again by `git log --oneline`:
>$ git log --oneline  
>dff5c7e (HEAD -> feature-a) add feature-a and feature-b change  
>84a807b Add feature-a change  
>b4b7a66 (master) init  

Cherry-pick a single commit from `feature-b`:
```bash
git checkout master
git cherry-pick <commit-hash>
```
if we want to cancel it we can do `git reset --hard HEAD~1`.  
This will delete the last commit and reset your branch to its previous state.


- `merge`: Adds both of the branches histories together with a special "merge commit."
- `rebase`: Moves the commits on top of the target branch, making it a straight timeline.

---

## Task 4: GitHub Pull Requests & Code Review
We can view all our branches by:
```bash
git branch # see all local branches
git branch -a # see local and remote branches
```

create remote repository (or in github UI):
```bash
gh repo create <repo_name> --public --source=. --remote=origin --push
```

Add the remote repository and push all branches:
```bash
git remote add origin https://github.com/<username>/<repo_name>.git
git push --all origin
```

can choose which branch to be the default (im changing to master):
```bash
gh repo edit --default-branch master
```

Create a pull request from `feature-a` into `master`:
```bash
gh pr create --base master --head feature-a --title "Merge feature-a" --body "This pull request merges feature-a into master."
```

---

## Task 5: Stash, Amend, and Cleanup
Make local changes and stash them:
```bash
echo "Temporary change" >> temp.txt
git add temp.txt
git stash
```

Restore the stash:
```bash
git stash pop
```

Amend the last commit:
```bash
git commit --amend -m "Updated commit message"
```

Clean up local branches already merged:
```bash
git branch --merged
git branch -d feature-b
```

</details>

******

<details>
<summary>Week 4 Summary Task – </summary>
<br />



</details>

******



<br/><br/>

[view week1_QA](./QA/week1_QA.md)  
[view week2_QA](./QA/week2_QA.md)  
[view week3_QA](./QA/week3_QA.md)
