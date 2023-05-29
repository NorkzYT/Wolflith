#!/bin/bash

#####################################################################################################################################################################

### Docker and Docker Compose Installer ###

#####################################################################################################################################################################

# This script installs and configures Docker on an Ubuntu system.
# It checks if Docker is already installed, and if not, installs it and Docker Compose.
# It also updates the system before installation and removes any previous versions of Docker.

# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
# Any command in a pipeline that fails will cause the whole pipeline to fail.
set -euoC pipefail

# Clear the terminal
clear

# Print the banner
docker_banner

# Check if Docker is already installed
if [ -x "$(command -v docker)" ] && [ -x "$(command -v docker-compose)" ]; then

    # If Docker is already installed, display a message and display the version of Docker
    sudo docker version && sudo docker-compose version
    echo "Docker and Docker Compose are already installed, skipping installation"

else

    # Either Docker or Docker Compose is not installed
    echo "Docker or Docker Compose is not installed"
    echo "Installing..."

    # If Docker is not installed, update the system and install the required packages
    ansible-playbook /home/user/Launchpad/Ansible/playbooks/docker.yml
    echo -e "\e[32mInstalled Docker and Docker Compose \e[0m"

    # Print the version of Docker and Docker Compose to confirm successful installation
    sudo docker version && sudo docker compose version

    echo -e "\e[32mTada! All is well. \e[0m"
fi
