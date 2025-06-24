# Week 8 – CI/CD to Azure VM Q&A Flashcards

### ❓ What is the goal of the Week 8 CI/CD pipeline?
<details><summary>Answer</summary>To automate deployment of a full-stack web app to an Azure VM using GitHub Actions.</details>

### ❓ How is the Azure VM created and configured?
<details><summary>Answer</summary>With `az vm create` using specific options like size, image, authentication (SSH), open ports, and static IP.</details>

### ❓ How are files deployed to the VM in GitHub Actions?
<details><summary>Answer</summary>Using `scp` to copy project files and `ssh` to run remote setup commands like `docker compose up`.</details>

### ❓ How is the app's health checked in the CI/CD workflow?
<details><summary>Answer</summary>A curl request checks if the app responds at `http://<VM-IP>:3000`. Failure to respond causes workflow failure.</details>

### ❓ What does `docker compose up -d --build` do?
<details><summary>Answer</summary>It builds images and starts containers in detached mode, useful for deploying app updates remotely.</details>

### ❓ How is a P1 Premium SSD disk created and attached?
<details><summary>Answer</summary>Using `az disk create` and `az vm disk attach`, specifying 4GB and `--tier P1`. Skips if already created.</details>

### ❓ How is the deployment log generated and saved?
<details><summary>Answer</summary>A GitHub Actions job collects VM info and appends a markdown log (`deployment_log.md`) with the current deployment info.</details>

### ❓ How is the deployment_log.md committed back to the repo?
<details><summary>Answer</summary>Using git config and push commands in the workflow, requiring `contents: write` permission.</details>

### ❓ What GitHub secret is needed to log in to Azure from Actions?
<details><summary>Answer</summary>`AZURE_CREDENTIALS`, containing a service principal with Contributor access in JSON format.</details>

### ❓ What should you do if the P1 disk is already attached?
<details><summary>Answer</summary>Skip the attach command or handle the error to avoid failure, since the disk is already attached to the VM.</details>
