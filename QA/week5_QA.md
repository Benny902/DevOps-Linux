# Week 5 – CI/CD, Linting, Deployment Q&A Flashcards


### ❓ What is CI/CD?
<details><summary>Answer</summary>
CI (Continuous Integration) is the practice of automatically testing and integrating code changes.  
CD (Continuous Deployment/Delivery) automates delivering tested code to production or staging environments.
</details>


### ❓ What is the main goal of CI/CD pipelines?
<details><summary>Answer</summary>
To automatically build, test, and deploy code changes, ensuring faster and more reliable software delivery.
</details>


### ❓ What is a GitHub Actions workflow?
<details><summary>Answer</summary>
A YAML file in `.github/workflows/` that defines automated steps triggered by events like `push`, `pull_request`, or scheduled jobs.
</details>


### ❓ What does `on: push` mean in a GitHub Actions workflow?
<details><summary>Answer</summary>
It triggers the workflow whenever a `git push` event occurs.
</details>


### ❓ What triggers can be used to start a GitHub Actions workflow?
<details><summary>Answer</summary>
`push`, `pull_request`, `schedule`, `workflow_dispatch`, and more.
</details>


### ❓ What is a job in GitHub Actions?
<details><summary>Answer</summary>
A job is a sequence of steps that run in the same virtual environment. Each job can run in parallel unless specified otherwise.
</details>


### ❓ What are steps in a GitHub Actions job?
<details><summary>Answer</summary>
Each `step` runs a command or uses an action. Steps execute sequentially within a job.
</details>


### ❓ What is the difference between a job and a step?
<details><summary>Answer</summary>
A **job** is a group of **steps**. Steps are individual tasks (like `npm install`, `npx eslint`) that run sequentially within a job.
</details>


### ❓ What is a GitHub Actions matrix?
<details><summary>Answer</summary>
A matrix allows running a job across multiple configurations (e.g., different Node.js versions).
</details>


### ❓ How do you run a job step only when previous steps succeed?
<details><summary>Answer</summary>
By default, steps run only if previous ones succeed. You can explicitly use `if: success()` for clarity.
</details>


### ❓ How do you ensure a step always runs even if previous steps fail?
<details><summary>Answer</summary>
Use `if: always()` to run the step regardless of success or failure.
</details>


### ❓ What is a GitHub Actions artifact?
<details><summary>Answer</summary>
An artifact is a file or folder (like logs or test results) saved from a workflow and downloadable from the UI.
</details>


### ❓ How can GitHub Actions notify Slack or Discord?
<details><summary>Answer</summary>
By using integrations like `slackapi/slack-github-action` or sending HTTP POST requests via `curl` with webhook URLs.
</details>


### ❓ How do you cache dependencies in GitHub Actions?
<details><summary>Answer</summary>
Use `actions/setup-node@v3` with `cache: 'npm'` and `cache-dependency-path` to cache `node_modules` based on lock files.
</details>


### ❓ How do you set up Node.js in GitHub Actions?
<details><summary>Answer</summary>
Use the `actions/setup-node@v3` action with the desired `node-version`.
</details>


### ❓ What is the purpose of `npm ci` in CI environments?
<details><summary>Answer</summary>
It installs dependencies using `package-lock.json` for faster and consistent builds.
</details>


### ❓ What does ESLint do?
<details><summary>Answer</summary>
ESLint analyzes JavaScript code for syntax, style, and logical errors based on defined rules.
</details>


### ❓ What does Prettier do?
<details><summary>Answer</summary>
Prettier is a code formatter that enforces a consistent style by parsing code and reprinting it.
</details>


### ❓ How do you run ESLint in a project?
<details><summary>Answer</summary>
Install it with `npm install eslint`, then run `npx eslint .`
</details>


### ❓ What is the benefit of using Prettier and ESLint together?
<details><summary>Answer</summary>
Prettier handles formatting, while ESLint focuses on code quality and error prevention. Together, they improve maintainability.
</details>


### ❓ What is a deploy hook in Render?
<details><summary>Answer</summary>
A deploy hook is a URL that can be triggered (e.g., via `curl`) to start a new deployment manually or from CI.
</details>


### ❓ What is the difference between `require()` and `import` in Node.js?
<details><summary>Answer</summary>
`require()` is used in CommonJS modules; `import` is used in ES Modules. ES Modules require `"type": "module"` in `package.json`.
</details>


### ❓ How do you serve static files using Express.js?
<details><summary>Answer</summary>
Use `app.use(express.static(__dirname))` to serve static files in the current directory.
</details>


### ❓ Why might `require` cause an error in Node.js 18+?
<details><summary>Answer</summary>
If `"type": "module"` is set in `package.json`, Node treats `.js` files as ES modules where `require()` is not allowed.
</details>


### ❓ What does `node server.js &` do in CI?
<details><summary>Answer</summary>
Starts the server in the background so the next command (e.g., `curl`) can test it without blocking.
</details>
