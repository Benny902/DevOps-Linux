# Week 1 Bash Practice – Q&A Flashcards

### ❓ What does 'pwd' do?
<details><summary>Answer</summary>

It prints the current working directory.

</details>

### ❓ What does 'ls' do?
<details><summary>Answer</summary>

It lists the contents of the current directory.

</details>

### ❓ What does 'mkdir devops_test' do?
<details><summary>Answer</summary>

It creates a new directory named 'devops_test'.

</details>

### ❓ What does 'cd devops_test' do?
<details><summary>Answer</summary>

It changes the current directory to 'devops_test'.

</details>

### ❓ What does 'touch testfile.txt' do?
<details><summary>Answer</summary>

It creates an empty file named 'testfile.txt'.

</details>

### ❓ What does 'rm testfile.txt' do?
<details><summary>Answer</summary>

It deletes the file named 'testfile.txt'.

</details>

### ❓ What does 'cd ..' do?
<details><summary>Answer</summary>

It moves up one directory level.

</details>

### ❓ What does 'rm -r devops_test' do?
<details><summary>Answer</summary>

It deletes the 'devops_test' directory and its contents recursively.

</details>

### ❓ What does 'groupadd devopsteam' do?
<details><summary>Answer</summary>

It creates a new group named 'devopsteam'.

</details>

### ❓ What does 'useradd -m -G devopsteam user1' do?
<details><summary>Answer</summary>

It creates a new user 'user1', adds them to 'devopsteam', and creates a home directory.

</details>

### ❓ What does 'groups user1' show?
<details><summary>Answer</summary>

It lists all groups the user 'user1' belongs to.

</details>

### ❓ What does 'chown user1:devopsteam file' do?
<details><summary>Answer</summary>

It changes the ownership of the file to user1 and group devopsteam.

</details>

### ❓ What does 'chmod 660 file' do?
<details><summary>Answer</summary>

It gives read/write permissions to the owner and group, and no permissions to others.

</details>

### ❓ What does 'ls -l file' show?
<details><summary>Answer</summary>

It shows the file’s permissions, owner, group, size, and last modified time.

</details>

### ❓ What does 'mkdir -p ~/project1/docs ~/project1/scripts' do?
<details><summary>Answer</summary>

It creates the full directory structure for project1 with subfolders docs and scripts.

</details>

### ❓ What does 'chmod 744 scripts' do?
<details><summary>Answer</summary>

Owner can read/write/execute; group and others can only read.

</details>

### ❓ What does 'chmod 777 docs' do?
<details><summary>Answer</summary>

Everyone can read/write/execute in the 'docs' directory.

</details>

### ❓ What does 'useradd -m -G devteam devuser' do?
<details><summary>Answer</summary>

It creates 'devuser', adds to 'devteam', and creates a home directory.

</details>

### ❓ What does 'chown $USER:devteam ~/project1' do?
<details><summary>Answer</summary>

Sets current user as owner and 'devteam' as the group for the project1 directory.

</details>

### ❓ What does 'chmod 740 ~/project1' do?
<details><summary>Answer</summary>

Owner has full access, group has read-only, others have no access.

</details>

### ❓ What does 'ls -lR ~/project1' do?
<details><summary>Answer</summary>

It recursively lists all files and directories inside ~/project1 with details.

</details>

### ❓ What does 'whoami' return?
<details><summary>Answer</summary>

It returns the username of the current user session.

</details>
