#!/bin/bash

# Set up project directory
PROJECT_DIR="hello-world-devcontainer"
mkdir -p $PROJECT_DIR && cd $PROJECT_DIR

# Step 1: Create a simple Hello World app
echo 'console.log("Hello, World!");' > app.js

# Step 2: Create the .devcontainer directory
mkdir .devcontainer

# Step 3: Create the devcontainer.json file
cat <<EOL > .devcontainer/devcontainer.json
{
  "name": "Hello World Dev Container",
  "build": {
    "dockerfile": "Dockerfile"
  },
  "settings": {
    "terminal.integrated.shell.linux": "/bin/bash"
  },
  "extensions": [
    "ms-vscode.vscode-typescript-tslint-plugin"
  ],
  "forwardPorts": [3000],
  "postCreateCommand": "npm install",
  "remoteUser": "node"
}
EOL

# Step 4: Create the Dockerfile
cat <<EOL > .devcontainer/Dockerfile
FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:latest

# Set the working directory
WORKDIR /workspace

# Copy project files
COPY . .

# Install dependencies (if you need npm packages)
RUN npm install

CMD ["node", "app.js"]
EOL

# Step 5: Initialize a new Node.js project
npm init -y

# Step 6: Open VS Code with the Dev Container
echo "Dev container setup complete. Opening VS Code..."
code .

echo "The development container is now set up. You can reopen the project in the container by running 'Remote-Containers: Reopen in Container' in VS Code."