#!/bin/bash

# Function to check Docker Compose installation
check_docker_compose_installed() {
    if ! command -v docker compose &>/dev/null; then
        echo "Docker Compose is not installed. Please install Docker Compose and try again."
        exit 1
    fi
}

# Function to change appdata location
change_appdata_location() {
    read -rp "Do you want to change the compose files current appdata location? (Default: /opt/appdata/) [y/N]: " response
    if [[ $response =~ ^[Yy]$ ]]; then
        read -rp "Enter the new docker container appdata location: " new_appdata_location

        find "/opt" -name "docker-compose.yml" -exec sed -i "s|/opt/appdata/|$new_appdata_location/|g" {} \;
        echo "Docker container appdata location has been updated to $new_appdata_location."
    else
        echo "Keeping the current docker container appdata location."
    fi
}

# Function to change Docker network name
change_docker_network_name() {
    read -rp "Do you want to change the compose files current docker network name? (Default: proxy) [y/N]: " response
    if [[ $response =~ ^[Yy]$ ]]; then
        read -rp "Enter the new docker network name: " new_docker_network_name
        find "/opt" -name "docker-compose.yml" -exec sed -i "s|proxy|$new_docker_network_name|g" {} \;
        echo "Docker network name has been updated to $new_docker_network_name."
    else
        echo "Keeping the current docker network name."
    fi
}

# Main execution flow
check_docker_compose_installed
change_appdata_location
change_docker_network_name
