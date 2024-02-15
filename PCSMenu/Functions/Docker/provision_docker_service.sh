#!/bin/bash

source Functions/PersonalizationFunctions.sh

# Default values
default_network_name="proxy"
default_appdata_location="/opt/appdata"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DIRECTORY_LOCATION=$(cat "$SCRIPT_DIR/../../../Temp/directory_location.txt")
SELECTED_SERVICE=$(cat /tmp/selected_docker_service.txt)
SELECTED_SERVICE_PATH=$(cat /tmp/selected_docker_service_path.txt)

cyanprint "Change Docker Network name from default 'proxy'? [y/N] "
read -p "" change_network_name
if [[ "$change_network_name" =~ ^[Yy] ]]; then
    cyanprint "Enter new Docker Network name: "
    read -p "" network_name
else
    network_name=$default_network_name
fi

cyanprint "Change appdata location from default '$default_appdata_location'? [y/N] "
read -p "" change_appdata_location
if [[ "$change_appdata_location" =~ ^[Yy] ]]; then
    cyanprint "Enter new appdata location: "
    read -p "" appdata_location
else
    appdata_location=$default_appdata_location
fi

# Create a YAML file with all the variables to pass to the Ansible playbook
cat <<EOF >/tmp/provisioning_docker_service_vars.yml
network_name: "$network_name"
appdata_location: "$appdata_location"
selected_service: "$SELECTED_SERVICE"
selected_service_path: "$SELECTED_SERVICE_PATH"
repo_path: "$DIRECTORY_LOCATION/Wolflith"
EOF

greenprint "Provisioning variables saved to /tmp/provisioning_docker_service_vars.yml."
