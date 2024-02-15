#!/bin/bash

# Function to check Docker Compose installation
check_docker_compose_installed() {
    if ! command -v docker compose &>/dev/null; then
        echo "Docker Compose is not installed. Please install Docker Compose and try again."
        exit 1
    fi
}

# Function to prompt for directory location
prompt_directory_location() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
    local saved_dir_location="$script_dir/../Temp/directory_location.txt"

    if [ -f "$saved_dir_location" ]; then
        directory_location=$(cat "$saved_dir_location")
        if [ -z "$directory_location" ] || [ ! -d "$directory_location" ]; then
            echo "Saved directory location is invalid. Please enter a new directory location."
        else
            echo "Using saved directory location: $directory_location"
            return
        fi
    fi

    read -p "Enter the directory location of the Wolflith repository: " directory_location
    if [ ! -d "$directory_location" ]; then
        echo "Directory '$directory_location' does not exist."
        exit 1
    fi
    echo "Directory validated: $directory_location"
    # Save the directory location for future use
    echo "$directory_location" >"$directory_location/Wolflith/Temp/directory_location.txt"
}

# Function to change appdata location
change_appdata_location() {
    read -p "Do you want to change the compose files current appdata location? (Default: /opt/appdata/) [y/N]: " response
    if [[ $response =~ ^[Yy]$ ]]; then
        read -p "Enter the new docker container appdata location: " new_appdata_location
        while ! [ -d "$new_appdata_location" ]; do
            echo "Invalid directory location. Please enter a valid directory."
            read -p "Enter the new docker container appdata location: " new_appdata_location
        done

        find "$directory_location" -name "docker-compose.yml" -exec sed -i "s|/opt/appdata/|$new_appdata_location/|g" {} \;
        echo "Docker container appdata location has been updated to $new_appdata_location."
    else
        echo "Keeping the current docker container appdata location."
    fi
}

# Function to change Docker network name
change_docker_network_name() {
    read -p "Do you want to change the compose files current docker network name? (Default: proxy) [y/N]: " response
    if [[ $response =~ ^[Yy]$ ]]; then
        read -p "Enter the new docker network name: " new_docker_network_name
        find "$directory_location" -name "docker-compose.yml" -exec sed -i "s|proxy|$new_docker_network_name|g" {} \;
        echo "Docker network name has been updated to $new_docker_network_name."
    else
        echo "Keeping the current docker network name."
    fi
}

# Main execution flow
check_docker_compose_installed
prompt_directory_location
change_appdata_location
change_docker_network_name
