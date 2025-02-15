FROM mcr.microsoft.com/vscode/devcontainers/javascript-node:latest

# Set the working directory
WORKDIR /workspace

# Copy project files
COPY . .

# Install dependencies (if you need npm packages)
RUN npm install

CMD ["node", "app.js"]
