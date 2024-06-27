# Docker-Based VS Code Web Environment

A Docker-based VS Code web environment with GPU support and HTTPS.

## Prerequisites

Before you begin, ensure you have the following installed on your host machine:

1. NVIDIA Drivers: Ensure that the NVIDIA drivers are installed.
2. Docker: Ensure that Docker is installed.
3. NVIDIA Container Toolkit: Install the NVIDIA Container Toolkit.

### Installing NVIDIA Container Toolkit

Follow the instructions from the NVIDIA Container Toolkit documentation to install the toolkit. For example, on Ubuntu, you can run:

1. Add the package repositories:
   - `distribution=$(. /etc/os-release;echo $ID$VERSION_ID)`
   - `curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -`
   - `curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list`

2. Install the NVIDIA Container Toolkit:
   - `sudo apt-get update`
   - `sudo apt-get install -y nvidia-docker2`

3. Restart the Docker daemon to complete the installation:
   - `sudo systemctl restart docker`

## Setup

### Step 1: Clone the Repository

Clone the repository to your local machine:

1. `git clone https://github.com/your-username/docker-vscode-web-environment.git`
2. `cd docker-vscode-web-environment`

### Step 2: Generate Self-Signed Certificates

Generate self-signed certificates using OpenSSL:

1. `mkdir -p certs`
2. `openssl req -newkey rsa:2048 -nodes -keyout certs/key.pem -x509 -days 365 -out certs/cert.pem`

This will create two files in the `certs` directory: `key.pem` (the private key) and `cert.pem` (the certificate).

### Step 3: Create a Workspace Directory

Create a directory named `workspace` in the same directory as your `Dockerfile` and `docker-compose.yml`. This directory will be mounted into the container and will serve as your project workspace.

1. `mkdir workspace`

### Step 4: Build and Run the Docker Container

Build the Docker image and run the container:

1. `docker-compose build`
2. `docker-compose up -d`

### Step 5: Access the VS Code Web Environment

Open your web browser and navigate to `https://localhost:8080`. You will be prompted to enter the password you specified in the `docker-compose.yml`.

### Step 6: Create a Python Virtual Environment ( Optional) 

Once you are logged in to the VS Code web environment, open a terminal within VS Code and create a virtual environment using the following commands:

1. `cd /home/coder/project`
2. `python3 -m venv myenv`
3. `source myenv/bin/activate`

### Step 7: Configure VS Code to Use the Virtual Environment ( Optional) 

1. Open the Command Palette in VS Code by pressing `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS).
2. Type `Python: Select Interpreter` and select it.
3. Choose the interpreter from the virtual environment you created. It should be listed as something like `Python 3.x.x (myenv)`.

### Step 8: Ensure the Virtual Environment is Activated Automatically ( Optional)

To ensure that the virtual environment is activated automatically when you open a new terminal in VS Code, add the following configuration to your `settings.json` file:

1. Open the Command Palette in VS Code by pressing `Ctrl+Shift+P` (or `Cmd+Shift+P` on macOS).
2. Type `Preferences: Open Settings (JSON)` and select it.
3. Add the following configuration to the `settings.json` file:

```json
{
    "python.pythonPath": "${workspaceFolder}/project/myenv/bin/python",
    "python.terminal.activateEnvironment": true
}
```

## Example Repository Structure

Your repository structure should look something like this:

```
docker-vscode-web-environment/
├── Dockerfile
├── docker-compose.yml
├── .gitignore
├── README.md
├── certs/
│   ├── cert.pem
│   └── key.pem
└── workspace/
    └── (your project files)
```

## License

This project is licensed under the MIT License.
