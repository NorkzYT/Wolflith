#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSMenu/PersonalizationFunc.sh

# Default values
default_network_name="proxy"
default_appdata_location="/opt/appdata"

SELECTED_SERVICE=$(cat /opt/Wolflith/Temp/selected_docker_service.txt)
SELECTED_SERVICE_PATH=$(cat /opt/Wolflith/Temp/selected_docker_service_path.txt)

provision_docker_service() {
    cyanprint "Change Docker Network name from default 'proxy'? [y/N] "
    read -rp "" change_network_name
    if [[ "$change_network_name" =~ ^[Yy] ]]; then
        cyanprint "Enter new Docker Network name: "
        read -rp "" network_name
    else
        network_name=$default_network_name
    fi

    cyanprint "Change appdata location from default '$default_appdata_location'? [y/N] "
    read -rp "" change_appdata_location
    if [[ "$change_appdata_location" =~ ^[Yy] ]]; then
        cyanprint "Enter new appdata location: "
        read -rp "" appdata_location
    else
        appdata_location=$default_appdata_location
    fi

    # Create a YAML file with all the variables to pass to the Ansible playbook
    cat <<EOF >/opt/Wolflith/Temp/provisioning_docker_service_vars.yml
network_name: "$network_name"
appdata_location: "$appdata_location"
selected_service: "$SELECTED_SERVICE"
selected_service_path: "$SELECTED_SERVICE_PATH"
EOF

    greenprint "Provisioning variables saved to /opt/Wolflith/Temp/provisioning_docker_service_vars.yml."

}

# Call the provision_docker_service function to start the process
provision_docker_service
