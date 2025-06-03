# Week 4 – Git Practice Q&A Flashcards

### ❓ What does `git init` do?
<details><summary>Answer</summary>
Initializes a new Git repository in the current directory.
</details>

### ❓ How to create a new branch called `feature-a`?
<details><summary>Answer</summary>
`git checkout -b feature-a` or `git switch -c feature-a`
</details>

### ❓ What is the command to switch to an existing branch?
<details><summary>Answer</summary>
`git checkout branch-name` or `git switch branch-name`
</details>

### ❓ How to see all available branches in the repository?
<details><summary>Answer</summary>
`git branch` for local, `git branch -a` for local + remote branches.
</details>

### ❓ What happens during a merge conflict?
<details><summary>Answer</summary>
Git can’t automatically merge changes; you must manually edit conflicting parts of the file, add it, and commit.
</details>

### ❓ How to resolve a merge conflict?
<details><summary>Answer</summary>
Edit the conflicted file to remove markers (e.g., `<<<<<<<`, `=======`, `>>>>>>>`), then:
```
git add file.txt
git commit -m "Resolve merge conflict"
```
</details>

### ❓ What does `git rebase feature-a` do?
<details><summary>Answer</summary>
Re-applies commits from `feature-a` onto the current branch’s tip (cleaner history).
</details>

### ❓ How to abort an in-progress rebase?
<details><summary>Answer</summary>
`git rebase --abort`
</details>

### ❓ What is `git cherry-pick`?
<details><summary>Answer</summary>
It applies a single commit from another branch to the current branch.
</details>

### ❓ How to undo the last cherry-pick commit?
<details><summary>Answer</summary>
`git reset --hard HEAD~1` (removes the last commit entirely).
</details>

### ❓ Difference between `rebase` and `merge`?
<details><summary>Answer</summary>
Rebase re-applies commits for a linear history; merge combines branches with a merge commit.
</details>

### ❓ How to push all local branches to the remote?
<details><summary>Answer</summary>
`git push --all origin`
</details>

### ❓ How to create a pull request in the terminal?
<details><summary>Answer</summary>
Use the GitHub CLI: `gh pr create --base main --head feature-a`
</details>

### ❓ How to set the default branch to `master`?
<details><summary>Answer</summary>
Using GitHub CLI: `gh repo edit --default-branch master`
</details>

### ❓ How to create a remote repository and push the local repo to it?
<details><summary>Answer</summary>
Using GitHub CLI: `gh repo create <repo-name> --public --source=. --remote=origin --push`
</details>

### ❓ What does `git stash` do?
<details><summary>Answer</summary>
Temporarily saves local changes (like a clipboard) and reverts to the last commit.
</details>

### ❓ How to reapply stashed changes?
<details><summary>Answer</summary>
`git stash pop`
</details>

### ❓ How to amend the last commit?
<details><summary>Answer</summary>
`git commit --amend`
</details>

### ❓ How to delete a local branch that has already been merged?
<details><summary>Answer</summary>
`git branch -d branch-name`
</details>
