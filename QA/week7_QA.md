# Week 7 – Azure VM & Docker Compose Deployment Q&A Flashcards

### ❓ What is an Azure VM?
<details><summary>Answer</summary> An Azure Virtual Machine (VM) is an on-demand, scalable computing resource in Azure, allowing you to run Linux or Windows servers in the cloud. 
</details>

### ❓ What is SSH and why is it used with VMs?
<details><summary>Answer</summary> SSH (Secure Shell) is a protocol used to securely connect to and manage remote servers, such as Azure VMs, for administration and deployment. 
</details>

### ❓ How do you generate an SSH key pair on Linux or Windows?
<details><summary>Answer</summary> Run `ssh-keygen -t rsa -b 2048` in your terminal and follow the prompts to create a public and private key. 
</details>

### ❓ How can you automate VM creation and setup with Azure CLI?
<details><summary>Answer</summary> Use `az vm create` with flags for resource group, name, image, size, username, and SSH key to script VM provisioning and setup. 
</details>

### ❓ What does rsync do when copying files to a VM?
<details><summary>Answer</summary> `rsync` efficiently copies files and directories to a remote VM, syncing only differences and supporting exclusion of unnecessary files. 
</details>

### ❓ Why do we use docker-compose on an Azure VM?
<details><summary>Answer</summary> `docker-compose` allows us to orchestrate and run multi-container apps on the VM easily, using a single `docker-compose.yml` file. 
</details>

### ❓ How can you execute remote commands on a VM using GitHub Actions?
<details><summary>Answer</summary> Use the `ssh` command with the private key to log in and run deployment scripts or restart services remotely from a workflow. 
</details>

### ❓ What does docker compose up -d --build do on a VM?
<details><summary>Answer</summary> It builds all images if needed and starts all services in detached mode, running the containers in the background. 
</details>

### ❓ How do you check if a service inside a container is healthy?
<details><summary>Answer</summary> Use healthchecks in `docker-compose.yml` and check status with `docker compose ps` or `docker inspect <container>`. 
</details>

### ❓ How do you retrieve logs from a remote VM in GitHub Actions?
<details><summary>Answer</summary> Run `docker compose logs` or `docker logs <container>` via SSH, save the output, and use `actions/upload-artifact` to upload logs. 
</details>

### ❓ What is the purpose of the docker compose down --remove-orphans command?
<details><summary>Answer</summary> It stops and removes all containers defined in the compose file, including those not defined anymore, to prevent orphaned containers. 
</details>

### ❓ What is the benefit of healthchecks in docker-compose.yml during CI/CD?
<details><summary>Answer</summary> They ensure that dependent containers (like the backend) are actually healthy and ready before running tests or starting the frontend. 
</details>

### ❓ How can you set environment variables in docker-compose.yml?
<details><summary>Answer</summary> Use the `environment:` block for each service to pass environment variables into containers (e.g., database connection strings). 
</details>

### ❓ What are some common troubleshooting steps if a container is not healthy?
<details><summary>Answer</summary> - Inspect container logs for errors. - Check healthcheck commands. - Ensure services are reachable and configuration is correct. - Rebuild images if dependencies changed. 
</details>

### ❓ What is the difference between docker-compose and docker compose?
<details><summary>Answer</summary> `docker compose` (space) is the newer plugin version built into Docker CLI; `docker-compose` (dash) is the older standalone Python tool. 
</details>

### ❓ How can you automate deployment to an Azure VM using GitHub Actions?
<details><summary>Answer</summary> Create a workflow that checks out code, copies files with `rsync`, SSHes into the VM, and runs `docker compose up -d --build`. 
</details>

### ❓ Why should you avoid including .git or node_modules in a deployment rsync?
<details><summary>Answer</summary> Excluding them makes deployments faster, avoids leaking secrets/history, and ensures containers build fresh dependencies for production. 
</details>

### ❓ How can you trigger a GitHub Actions workflow manually?
<details><summary>Answer</summary> Include `workflow_dispatch:` in the workflow YAML to enable manual runs from the GitHub UI. 
</details>

### ❓ What does chmod 600 key.pem do in the deploy script?
<details><summary>Answer</summary> It restricts permissions on the private SSH key so only the current user can read/write, improving security. 
</details>

### ❓ What command shows all running containers on a VM?
<details><summary>Answer</summary> `docker ps` or `docker compose ps` lists all running containers and their statuses. 
</details>
