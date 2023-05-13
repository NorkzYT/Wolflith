#!/bin/bash

#####################################################################################################################################################################

### Run Manual Docker Commands ###

#####################################################################################################################################################################

# Exit immediately if a command exits with a non-zero status.
# Treat unset variables as an error when substituting.
# Any command in a pipeline that fails will cause the whole pipeline to fail.
set -euoC pipefail

# Check if Docker is already installed
if [ -x "$(command -v docker)" ] && [ -x "$(command -v docker-compose)" ]; then

    echo "Docker and Docker Compose are installed, continue..."
    # Prompt the user for a Docker command
    read -p "Enter a Docker command to run (only enter what is after docker): " command

    # Run the Docker command
    eval "docker $command"

else

    # Tell the user to install Docker and Docker Compose first
    echo "Install Docker and Docker Compose first"

fi
