# Week 6 – Docker & Containerization Q&A Flashcards

### ❓ What is Docker?
<details><summary>Answer</summary>
Docker is a platform that allows you to package applications and their dependencies into lightweight, portable containers that can run consistently across different environments.
</details>

### ❓ What is a Docker container?
<details><summary>Answer</summary>
A Docker container is a runnable instance of a Docker image, containing everything needed to run an application: code, runtime, libraries, and environment variables.
</details>

### ❓ What is a Docker image?
<details><summary>Answer</summary>
A Docker image is a read-only template used to create containers. Images include application code, dependencies, and system tools, and can be shared via registries.
</details>

### ❓ What is the purpose of a Dockerfile?
<details><summary>Answer</summary>
A Dockerfile is a text file containing instructions to build a Docker image, specifying the base image, files to copy, dependencies to install, and how to run the application.
</details>

### ❓ What does `FROM node:18-alpine` do in a Dockerfile?
<details><summary>Answer</summary>
It sets the base image for your container to Node.js version 18 on the lightweight Alpine Linux distribution, reducing image size.
</details>

### ❓ What is the difference between `node:alpine` and `node:slim`?
<details><summary>Answer</summary>
`alpine` is even smaller but uses musl libc (sometimes breaking native modules); `slim` is larger but more compatible, using Debian with minimal packages.
</details>

### ❓ What does `WORKDIR /app` do in a Dockerfile?
<details><summary>Answer</summary>
Sets the working directory for following commands. All `COPY`, `RUN`, and `CMD` commands will use `/app` as the current directory.
</details>

### ❓ What is `.dockerignore` and why is it important?
<details><summary>Answer</summary>
A `.dockerignore` file tells Docker which files/folders to exclude from the build context, making builds faster and more secure by not copying sensitive or unnecessary files.
</details>

### ❓ What is Docker Compose and why use it?
<details><summary>Answer</summary>
Docker Compose allows you to define and run multi-container Docker applications using a YAML file, simplifying orchestration of complex setups.
</details>

### ❓ How do containers communicate in Docker Compose?
<details><summary>Answer</summary>
All services in the same Compose file are placed on a default or user-defined network and can refer to each other by service name as hostname.
</details>

### ❓ How do you persist MongoDB data in Docker?
<details><summary>Answer</summary>
By mounting a volume in the `docker-compose.yml` (e.g., `mongo-data:/data/db`), database data is stored outside the container and survives restarts.
</details>

### ❓ What does `depends_on` do in Docker Compose?
<details><summary>Answer</summary>
It ensures a service starts only after its dependencies (other services) are started, but does not guarantee they are "ready"—just that the containers have started.
</details>

### ❓ What is a HEALTHCHECK in Docker, and how do you use it?
<details><summary>Answer</summary>
A `HEALTHCHECK` instruction in a Dockerfile defines a command for Docker to periodically run inside the container to determine if it is healthy (e.g., checking a web endpoint).
</details>

### ❓ How can you see a container's health status?
<details><summary>Answer</summary>
Run `docker ps` to see the health status or `docker inspect <container>` to view detailed health info and last check results.
</details>

### ❓ How do you tag a Docker image using semantic versioning?
<details><summary>Answer</summary>
Use `docker build -t myapp:1.0.0 .` to tag your image with a version, following the MAJOR.MINOR.PATCH pattern.
</details>

### ❓ What is semantic versioning?
<details><summary>Answer</summary>
A versioning scheme (`MAJOR.MINOR.PATCH`, e.g. `1.2.3`) that helps communicate the impact of changes: breaking (`MAJOR`), features (`MINOR`), or fixes (`PATCH`).
</details>

### ❓ How do you run all containers defined in `docker-compose.yml`?
<details><summary>Answer</summary>
Use `docker-compose up --build` to build images (if needed) and start all defined services.
</details>

### ❓ How does the backend connect to MongoDB in Docker Compose?
<details><summary>Answer</summary>
The backend uses the hostname `mongo` (service name) in its MongoDB URI (e.g., `mongodb://mongo:27017/mydb`) to connect via Docker's network.
</details>

### ❓ How can you check container logs?
<details><summary>Answer</summary>
Use `docker logs <container_name_or_id>` to view the output (stdout/stderr) of a running container.
</details>

### ❓ How does GitHub Actions interact with Docker in CI/CD?
<details><summary>Answer</summary>
GitHub Actions can build, test, and push Docker images automatically on every push or tag using YAML workflow files.
</details>

### ❓ How can you notify Slack or Discord from a GitHub Actions workflow?
<details><summary>Answer</summary>
Use a Slack GitHub Action or send a webhook POST (e.g., using `curl`) to your Slack or Discord webhook URL as a workflow step.
</details>

### ❓ What is the benefit of using containers for development and production?
<details><summary>Answer</summary>
Containers ensure consistent environments between development, testing, and production, minimizing "it works on my machine" issues.
</details>

### ❓ How do you scale services with Docker Compose?
<details><summary>Answer</summary>
Use `docker-compose up --scale <service>=N` to run multiple instances of a service (works well for stateless services).
</details>

### ❓ What command stops and removes all containers and volumes defined in a Compose file?
<details><summary>Answer</summary>
`docker-compose down -v` stops all services and removes all containers and named volumes.
</details>

### ❓ What does `EXPOSE` do in a Dockerfile?
<details><summary>Answer</summary>
Documents which port the container listens on at runtime, helping with container linking but not actually publishing the port outside unless mapped by Docker run/Compose.
</details>

### ❓ Why should you use a lightweight base image for Node.js or Python apps?
<details><summary>Answer</summary>
It reduces image size, builds faster, minimizes security surface, and speeds up deployments.
</details>

### ❓ What are the main steps to containerize a full-stack app with Docker?
<details><summary>Answer</summary>
1. Write a Dockerfile for each service.  
2. Add a `.dockerignore`.  
3. Write a `docker-compose.yml` for multi-container orchestration.  
4. Add healthchecks, persistent volumes, and tags.  
5. Build/test/deploy using CI/CD.
</details>
