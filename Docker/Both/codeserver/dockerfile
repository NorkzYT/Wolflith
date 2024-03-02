# Stage 1: Golang latest version
FROM golang:latest AS golang

# Stage 2: Node.js with a specific version
FROM node:lts-slim AS nodejs

# Stage 3: Main image
FROM linuxserver/code-server:latest

# User will be root
USER root

# Update package information and install packages
RUN apt-get update && \
    apt-get install -y lsb-release curl ca-certificates gnupg make gh openjdk-21-jdk openjdk-21-source shellcheck && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Add Docker's official GPG key and repository
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/docker.gpg && \
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list && \
    apt-get update && \
    apt-get -y --no-install-recommends install docker-ce docker-ce-cli containerd.io docker-compose-plugin && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Copy Go binaries from the Golang stage
COPY --from=golang /usr/local/go/ /usr/local/go/

# Set Go environment path
ENV PATH="/usr/local/go/bin:${PATH}"

# Copy Node.js from the Node.js stage
COPY --from=nodejs /usr/local/bin /usr/local/bin
COPY --from=nodejs /usr/local/lib/node_modules /usr/local/lib/node_modules

# Install Bun and OpenCommit globally using the installed Node.js
RUN npm install -g bun opencommit

# Set work directory
RUN mkdir -p /opt/app
WORKDIR /opt/app

# --------------------------------------------------------------------------------------
# https://github.com/prisma/prisma/issues/8478#issuecomment-1335444581
#
# DockerFile Practices:
# http://bitjudo.com/blog/2014/03/13/building-efficient-dockerfiles-node-dot-js/
# https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
# https://docs.bitnami.com/tutorials/best-practices-writing-a-dockerfile
