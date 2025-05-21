# Week 3 Bash Practice – Q&A Flashcards

### ❓ What does the remote log analyzer script do?
<details><summary>Answer</summary>

It connects to a remote server via SSH, downloads `.log`, `.zip`, `.tar`, and `.tar.gz` files, extracts them, and analyzes them for keyword occurrences.

</details>

### ❓ What is the purpose of `TMP_DIR` in the script?
<details><summary>Answer</summary>

`TMP_DIR` is a temporary local directory where all downloaded and extracted files are stored for analysis.

</details>

### ❓ How does the script connect to the remote VM?
<details><summary>Answer</summary>

Using SSH (`ssh user@host`) to run commands remotely and `rsync` or `scp` to copy files.

</details>

### ❓ What file types does the script extract?
<details><summary>Answer</summary>

`.zip`, `.tar`, and `.tar.gz` files.

</details>

### ❓ How are the extracted `.log` files processed?
<details><summary>Answer</summary>

Each `.log` file is scanned for the specified keywords, and the occurrences are counted and reported.

</details>

### ❓ What output files are generated?
<details><summary>Answer</summary>

`remote_report_<timestamp>.txt` and `remote_report_<timestamp>.csv`.

</details>

### ❓ What is the purpose of the wrapper script?
<details><summary>Answer</summary>

To abstract remote fetching and archive extraction logic before passing local logs to the main analyzer script.

</details>

### ❓ What does `shift 2` do in the wrapper script?
<details><summary>Answer</summary>

It removes the first two positional arguments (remote host and directory) so the rest can be forwarded to the analyzer.

</details>

### ❓ What does `PASSTHRU_ARGS=("$@")` store?
<details><summary>Answer</summary>

All remaining arguments after `shift 2`, which are passed to the local analyzer script.

</details>

### ❓ What is `realpath --relative-to` used for?
<details><summary>Answer</summary>

To get the relative path of a log file within the temporary folder for display in the report.

</details>

### ❓ What happens if `--keywords` is not passed to the wrapper?
<details><summary>Answer</summary>

The wrapper prints an error and usage help, then exits.

</details>

### ❓ Why do we use `tee -a` when writing to TXT reports?
<details><summary>Answer</summary>

To both display output in the terminal and append it to the report file.

</details>

### ❓ What does `grep -o "$keyword"` do?
<details><summary>Answer</summary>

Prints each match of the keyword on a new line, allowing counting with `wc -l`.

</details>

### ❓ Why is `2>/dev/null` used with `grep`?
<details><summary>Answer</summary>

To suppress errors when a file is unreadable or binary.

</details>

### ❓ What is the role of `chmod +x` in the wrapper?
<details><summary>Answer</summary>

Ensures the analyzer script is executable before calling it.

</details>

### ❓ What is the role of `--recursive`?
<details><summary>Answer</summary>

When passed, the script finds files in all subdirectories of the remote folder.

</details>

### ❓ Why do we use `"$TMP_DIR"` as the first arg to the analyzer?
<details><summary>Answer</summary>

It tells the analyzer where the local logs (downloaded from remote) are located.

</details>

### ❓ What does `find ... -type f -iname "*.log"` do?
<details><summary>Answer</summary>

Finds all `.log` files (case-insensitive) in the specified directory.

</details>

### ❓ How is total execution time calculated?
<details><summary>Answer</summary>

Using `date +%s.%N` to capture start and end time and `bc` to compute duration.

</details>

### ❓ How is `--color` handled in both scripts?
<details><summary>Answer</summary>

When passed, it triggers ANSI color formatting for terminal output.

</details>
"""