#!/bin/bash

# Check if Docker Compose is installed
if ! command -v docker compose &>/dev/null; then
    echo "Docker Compose is not installed. Please install Docker Compose and try again."
    exit 1
fi

# Get the directory location of the Wolflith repository from the input variable
directory_location="$1"

# Check if the location exists
if ! [[ -d "$directory_location" ]]; then
    echo "Directory '$directory_location' does not exist."
    exit 1
fi

echo ""

# Prompt the user if they want to change the current docker container appdata location
read -p "Do you want to change the current docker container appdata location? (Default: /mnt/appdata/) [y/N]: " change_appdata_location

# Set the appdata location based on user input
if [[ $change_appdata_location =~ ^[Yy]$ ]]; then
    read -p "Enter the new docker container appdata location: " new_appdata_location
    # Validate the directory location
    while ! [[ -d "$new_appdata_location" ]]; do
        echo "Invalid directory location. Please enter a valid directory."
        read -p "Enter the new docker container appdata location: " new_appdata_location
    done

    # Find docker-compose.yml files in the specified directory
    docker_compose_files=$(find "$directory_location/Wolflith/Docker" -name "docker-compose.yml")

    # Iterate through each docker-compose.yml file and replace the appdata location
    for file in $docker_compose_files; do
        sed -i "s~/mnt/appdata/~$new_appdata_location/~" "$file"
    done

    echo "Docker container appdata location has been updated successfully."
fi

echo ""

# Prompt the user if they want to change the current docker network name
read -p "Do you want to change the current docker network name? (Default: proxy) [y/N]: " change_docker_network_name

# Set the docker network name based on user input
if [[ $change_docker_network_name =~ ^[Yy]$ ]]; then
    read -p "Enter the new docker network name: " new_docker_network_name

    # Find docker-compose.yml files in the specified directory
    docker_compose_files=$(find "$directory_location/Wolflith/Docker" -name "docker-compose.yml")

    # Iterate through each docker-compose.yml file and replace the docker network name
    for file in $docker_compose_files; do
        sed -i "s/proxy/$new_docker_network_name/g" "$file"
    done

    echo ""
    echo "Docker network name has been updated successfully."
fi

echo ""
echo "Docker Compose files have been updated successfully."
