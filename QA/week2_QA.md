# Week 2 Bash Practice – Q&A Flashcards

### ❓ What does '#!/bin/bash' do at the top of a script?
<details><summary>Answer</summary>

It tells the system to use the Bash shell to interpret the script.

</details>

### ❓ What is the purpose of 'chmod +x script.sh'?
<details><summary>Answer</summary>

It makes the script executable.

</details>

### ❓ What does '$1' represent in a Bash script?
<details><summary>Answer</summary>

The first argument passed to the script.

</details>

### ❓ What does '-z "$1"' check for?
<details><summary>Answer</summary>

It checks if the argument is an empty string (missing input).

</details>

### ❓ What is the difference between '-f' and '-d' in 'if' checks?
<details><summary>Answer</summary>

'-f' checks if it's a file; '-d' checks if it's a directory.

</details>

### ❓ What does 'du -k' do?
<details><summary>Answer</summary>

Shows file size in kilobytes.

</details>

### ❓ What is the purpose of 'cut -f1' after 'du -k'?
<details><summary>Answer</summary>

Extracts just the size (first column) from the output.

</details>

### ❓ Why do we use '-f "$file"' inside the loop?
<details><summary>Answer</summary>

To ignore directories and only process regular files.

</details>

### ❓ What does 'grep -c "ERROR"' count?
<details><summary>Answer</summary>

The number of lines containing 'ERROR'.

</details>

### ❓ What does 'grep -o "ERROR" | wc -l' count?
<details><summary>Answer</summary>

The total number of 'ERROR' matches, not lines.

</details>

### ❓ What does 'awk -F',' '{ print $2 }'' do?
<details><summary>Answer</summary>

Uses comma as the delimiter and prints the second column.

</details>

### ❓ What does '$@' mean in 'main "$@"'?
<details><summary>Answer</summary>

It passes all arguments to the main function exactly as received.

</details>

### ❓ What is the role of 'shift' in argument parsing?
<details><summary>Answer</summary>

It removes the current argument and moves to the next one.

</details>

### ❓ What does 'basename "$1"' do?
<details><summary>Answer</summary>

Returns only the filename portion of a path.

</details>

### ❓ Why use 'tee -a "$REPORT_TXT"' instead of 'echo >> file'?
<details><summary>Answer</summary>

'tee -a' prints to terminal and appends to the file at the same time.

</details>

### ❓ Why do we use '2>/dev/null' after 'grep'?
<details><summary>Answer</summary>

To suppress errors (e.g., binary file, permission denied).

</details>

### ❓ What is '%-11s' in 'printf'?
<details><summary>Answer</summary>

It formats the string left-aligned in a column 11 characters wide.

</details>

### ❓ What does '\e[1;33m' and '\e[0m' do?
<details><summary>Answer</summary>

'\e[1;33m' sets yellow bold text, and '\e[0m' resets formatting.

</details>

### ❓ Why use 'date +%s.%N' and 'bc' to compute duration?
<details><summary>Answer</summary>

'date +%s.%N' gives high-precision time, and 'bc' is needed for float math.

</details>

### ❓ What does 'generate_report()' do?
<details><summary>Answer</summary>

Scans log files, counts keyword matches, writes TXT/CSV reports.

</details>

### ❓ What’s the purpose of 'validate_input()'?
<details><summary>Answer</summary>

Ensures the log directory and keywords are valid before continuing.

</details>
