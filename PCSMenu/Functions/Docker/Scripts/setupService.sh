#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source Functions/PersonalizationFunctions.sh

# Ensure the selected service and path are provided
if [ ! -f "/tmp/selected_docker_service.txt" ] || [ ! -f "/tmp/selected_docker_service_path.txt" ]; then
    redprint "Selected Docker service or path is missing. Please run selectService.sh first."
    exit 1
fi

cyanprint "Do you want to set up the environment variables? [y/N]: "
read -p "" setup_env

if [[ $setup_env =~ ^[Yy]$ ]]; then
    selected_service=$(cat /tmp/selected_docker_service.txt)
    selected_service_path=$(cat /tmp/selected_docker_service_path.txt)
    env_example_path="$selected_service_path/.env"
    env_file="/tmp/env_vars_for_ansible.yml"

    if [ -f "$env_example_path" ]; then
        greenprint "Preparing environment variables for $selected_service based on .env..."
        echo "" >"$env_file" # Clear or create the env file

        while IFS= read -r line || [[ -n "$line" ]]; do
            if [[ "$line" =~ ^[A-Z_]+="'xxx'"$ ]] || [[ "$line" =~ ^[A-Z_]+=xxx$ ]]; then
                var_name=$(echo "$line" | cut -d '=' -f1)
                cyanprint "Please enter value for $var_name: "
                read value </dev/tty

                if [ -n "$value" ]; then
                    echo "$var_name='$value'" >>"$env_file"
                else
                    echo "$var_name='xxx'" >>"$env_file"
                fi
            elif [[ "$line" =~ ^[A-Z_]+=.+ ]]; then
                var_name=$(echo "$line" | cut -d '=' -f1)
                var_value=$(echo "$line" | cut -d '=' -f2- | sed "s/^'//;s/'$//")
                echo "$var_name='$var_value'" >>"$env_file"
            fi
        done <"$env_example_path"

        greenprint "$selected_service environment variables saved to $env_file."
    else
        yellowprint "No .env file found for $selected_service. Skipping environment variable configuration."
    fi
else
    env_file="/tmp/env_vars_for_ansible.yml"
    yellowprint "Skipping environment variable setup."
    >"$env_file"
    greenprint "Environment variable setup file cleared."
fi
