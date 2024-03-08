#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

# Script to update docker-compose.yml with appdata_location and network_name from provisioning_docker_service_vars.yml

# Validate service name input
if [ -z "$1" ]; then
    echo "Service name not provided. Usage: $0 <service_name>"
    exit 1
fi

# Define paths
provisioning_vars_path="/tmp/provisioning_docker_service_vars.yml"
docker_compose_path="/home/docker/$1/docker-compose.yml"

# Read variables from provisioning_docker_service_vars.yml
network_name=$(awk '/network_name:/ {print $2}' "$provisioning_vars_path" | tr -d '"')
appdata_location=$(awk '/appdata_location:/ {print $2}' "$provisioning_vars_path" | tr -d '"')

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
    sed -i "s|/opt/appdata|${appdata_location}|g" "$docker_compose_path"

    echo "docker-compose.yml updated successfully."
else
    echo "One or more required variables are missing in provisioning_docker_service_vars.yml."
    exit 1
fi
