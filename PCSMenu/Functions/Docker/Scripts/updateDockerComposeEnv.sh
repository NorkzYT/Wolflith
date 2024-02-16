#!/bin/bash

# Script to update docker-compose.yml with appdata_location and network_name from provisioning_docker_service_vars.yml

# Validate service name input
if [ -z "$1" ]; then
    echo "Service name not provided. Usage: $0 <service_name>"
    exit 1
fi

# Define paths
env_example_path="/home/docker/$1/.env"
env_vars_path="/tmp/env_vars_for_ansible.yml"
output_env_path="/home/docker/$1/.env"
provisioning_vars_path="/tmp/provisioning_docker_service_vars.yml"
docker_compose_path="/home/docker/$1/docker-compose.yml"

# Check if required files exist
if [ ! -f "$env_example_path" ] || [ ! -f "$env_vars_path" ]; then
    echo "Required files are missing. Ensure both .env and env_vars_for_ansible.yml are present."
    exit 1
fi

# Backup the current .env file
cp "$env_path" "${env_path}.bak"

# Iterate through each line in env_vars_for_ansible.yml
while IFS= read -r line; do
    # Extract the key and value, trimming quotes from the value
    key=$(echo "$line" | cut -d '=' -f 1)
    value=$(echo "$line" | cut -d '=' -f 2-)

    # Check if key exists in .env and its value is 'xxx', then replace it
    if grep -q "^$key='xxx'$" "$env_path"; then
        sed -i "s|^$key='xxx'$|$key=$value|g" "$env_path"
    elif ! grep -q "^$key=" "$env_path"; then
        # If the key does not exist in .env, add it
        echo "$key=$value" >>"$env_path"
    fi
done <"$env_vars_path"

echo ".env file updated successfully."

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

    # Replace /opt/appdata with the actual appdata_location in volumes
    # This command targets the specific volume path for the configuration
    sed -i "s|/opt/appdata/webtop|$appdata_location/$selected_service|g" "$docker_compose_path"

    echo "docker-compose.yml updated successfully."
else
    echo "One or more required variables are missing in provisioning_docker_service_vars.yml."
    exit 1
fi
