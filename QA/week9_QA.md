# Week 9 – Terraform on Azure Q&A Flashcards

### ❓ What is the goal of the Week 9 project?
<details><summary>Answer</summary>To provision and manage Azure infrastructure using Terraform, including networking, VM, deployment, and validation tasks.</details>

### ❓ How is the Azure infrastructure modularized in Terraform?
<details><summary>Answer</summary>Each component (resource group, network, VM) is defined as a separate module with its own `main.tf`, `variables.tf`, and `outputs.tf` files.</details>

### ❓ How is the SSH key handled securely in GitHub Actions?
<details><summary>Answer</summary>The private key is stored as a GitHub secret (`VM_SSH_KEY`) and injected into the runner at runtime for SSH access.</details>

### ❓ Why is the resource group sometimes imported conditionally?
<details><summary>Answer</summary>To prevent Terraform from trying to re-create an existing resource group that already exists in Azure but is not in state.</details>

### ❓ How are public IP addresses configured for the VM?
<details><summary>Answer</summary>With a `Static` allocation method via the `azurerm_public_ip` resource to ensure the IP doesn't change between reboots.</details>

### ❓ Why is the frontend not accessible after reboot initially?
<details><summary>Answer</summary>Because the NSG (network security group) was missing an inbound rule to allow traffic on port `4000`, which was later added.</details>

### ❓ How is a reboot and health check performed automatically?
<details><summary>Answer</summary>A GitHub Actions workflow reboots the VM via SSH, waits, then uses `curl` to verify the backend is reachable at `:3000`.</details>

### ❓ What ports are allowed in the final NSG configuration?
<details><summary>Answer</summary>Ports 22 (SSH), 3000 (backend), and 4000 (frontend) are allowed for inbound traffic from all sources.</details>

### ❓ How is the deployment log updated?
<details><summary>Answer</summary>A GitHub Actions job queries VM details (IP, region, size, image) and appends a markdown section to `deployment_log.md`, then commits it to the repo.</details>

### ❓ What GitHub secret is required for Azure login in workflows?
<details><summary>Answer</summary>`AZURE_CREDENTIALS`, which holds the JSON for a service principal with Contributor role in the target subscription.</details>

