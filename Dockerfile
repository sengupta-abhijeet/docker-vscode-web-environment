# Use the official NVIDIA CUDA base image
FROM nvidia/cuda:11.2.2-cudnn8-runtime-ubuntu20.04

# Install necessary packages
RUN apt-get update && \
    apt-get install -y python3 python3-venv gnupg wget curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# Set environment variables
ENV PASSWORD=pass1234

# Copy SSL certificates
COPY certs /home/coder/certs

# Expose the port code-server will run on
EXPOSE 2323

# Create a user and set permissions
RUN useradd -m coder && \
    mkdir -p /home/coder/.config && \
    chown -R coder:coder /home/coder

# Switch to the coder user
USER coder

# Customize the shell prompt to preserve the virtual environment marker
RUN echo 'if [ -n "$VIRTUAL_ENV" ]; then PS1="(`basename \"$VIRTUAL_ENV\"`) $PS1"; fi' >> /home/coder/.bashrc && \
    echo 'PS1="\u@\h:\w\$ "' >> /home/coder/.bashrc

# Start code-server with password protection and SSL
CMD ["code-server", "--auth", "password", "--bind-addr", "0.0.0.0:2323", "--cert", "/home/coder/certs/cert.pem", "--cert-key", "/home/coder/certs/key.pem"]
