#!/bin/bash

# Script to generate .env file from .env.example and values in env_vars_for_ansible.yml and -
# to update docker-compose.yml with appdata_location and network_name from provisioning_docker_service_vars.yml

# Validate service name input
if [ -z "$1" ]; then
    echo "Service name not provided. Usage: $0 <service_name>"
    exit 1
fi

# Define paths
env_example_path="/home/docker/$1/.env.example"
env_vars_path="/tmp/env_vars_for_ansible.yml"
output_env_path="/home/docker/$1/.env"
provisioning_vars_path="/tmp/provisioning_docker_service_vars.yml"
docker_compose_path="/home/docker/$1/docker-compose.yml"

# Check if required files exist
if [ ! -f "$env_example_path" ] || [ ! -f "$env_vars_path" ]; then
    echo "Required files are missing. Ensure both .env.example and env_vars_for_ansible.yml are present."
    exit 1
fi

# Create or clear the .env file
>"$output_env_path"

# Read .env.example and extract variable names
grep '^[A-Z_]\+=' $env_example_path | while read -r line; do
    var_name=$(echo "$line" | cut -d '=' -f1)
    # Look for the variable in env_vars_for_ansible.yml and append it to the .env file
    grep "^$var_name=" "$env_vars_path" >>"$output_env_path"
done

echo ".env file generated successfully."

# Read variables from provisioning_docker_service_vars.yml
network_name=$(awk '/network_name:/ {print $2}' "$provisioning_vars_path" | tr -d '"')
appdata_location=$(awk '/appdata_location:/ {print $2}' "$provisioning_vars_path" | tr -d '"/"')
selected_service=$(awk '/selected_service:/ {print $2}' "$provisioning_vars_path" | tr -d '"')

# Update docker-compose.yml with the new network_name and appdata_location
if [ -n "$network_name" ] && [ -n "$appdata_location" ]; then
    # Ensure the appdata_location does not end with a slash
    appdata_location=${appdata_location%/}

    # Update the network name for services
    sed -i "s|- proxy|- $network_name|g" "$docker_compose_path"

    # Update the global network name definition
    sed -i "s|proxy:|$network_name:|g" "$docker_compose_path"

    # Replace /mnt/appdata with the actual appdata_location in volumes
    # This command targets the specific volume path for the configuration
    sed -i "s|/mnt/appdata/webtop|$appdata_location/$selected_service|g" "$docker_compose_path"

    echo "docker-compose.yml updated successfully."
else
    echo "One or more required variables are missing in provisioning_docker_service_vars.yml."
    exit 1
fi
