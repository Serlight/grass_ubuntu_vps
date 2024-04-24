#!/bin/bash
# Remove existing Docker packages
apt-get remove -y docker \
                  docker.io
# Install required dependencies
apt-get update
apt-get install -y apt-transport-https \
           ca-certificates \
           curl \
           software-properties-common
# Add Docker repository and update repository URL
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
# Update repository cache
apt-get update
# Install Docker
apt-get install -y docker-ce
# Start Docker service
systemctl start docker
# Optional: Enable Docker to start on boot
systemctl enable docker
docker pull camislav/grass
docker run -d --name Grass -p 8080:80 -e GRASS_USE=$grass_account -e GRASS_PASS=$grass_password camislav/grass
echo "Docker installation and configuration completed successfully."
