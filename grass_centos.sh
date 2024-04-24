#!/bin/bash

# Remove existing Docker packages
yum remove -y docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine \
                  docker-ce

# Install required dependencies
yum install -y yum-utils \
           device-mapper-persistent-data \
           lvm2 --skip-broken

# Add Docker repository and update repository URL
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
sed -i 's|download.docker.com|mirrors.aliyun.com/docker-ce|g' /etc/yum.repos.d/docker-ce.repo

# Update repository cache
yum makecache fast

# Install Docker
yum install -y docker-ce

# Start Docker service
systemctl start docker

# Optional: Enable Docker to start on boot
systemctl enable docker

docker pull camislav/grass

docker run -d --name Grass -p 8080:80 -e GRASS_USE=$grass_account -e GRASS_PASS=$grass_password camislav/grass

echo "Docker installation and configuration completed successfully."
