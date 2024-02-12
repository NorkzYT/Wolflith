#!/bin/bash

source Functions/PersonalizationFunctions.sh

# Ensure the selected service and path are provided
if [ ! -f "/tmp/selected_docker_service.txt" ] || [ ! -f "/tmp/selected_docker_service_path.txt" ]; then
    redprint "Selected Docker service or path is missing. Please run select_service.sh first."
    exit 1
fi

cyanprint "Do you want to set up the environment variables? [y/N]: "
read -p "" setup_env

if [[ $setup_env =~ ^[Yy]$ ]]; then
    selected_service=$(cat /tmp/selected_docker_service.txt)
    selected_service_path=$(cat /tmp/selected_docker_service_path.txt)
    env_example_path="$selected_service_path/.env.example"
    env_file="/tmp/env_vars_for_ansible.yml"

    if [ -f "$env_example_path" ]; then
        greenprint "Preparing environment variables for $selected_service based on .env.example..."
        echo "" >"$env_file" # Clear or create the env file

        while IFS= read -r line; do
            if [[ "$line" =~ ^[A-Z_]+=.+ ]]; then
                var_name=$(echo "$line" | cut -d '=' -f1)
                cyanprint -n "Please enter value for $var_name: "
                read value </dev/tty

                if [ -n "$value" ]; then
                    # If value is provided by user, use it
                    echo "$var_name='$value'" >>"$env_file"
                else
                    # If no value is provided, just write the variable name without a value
                    echo "$var_name=''" >>"$env_file"
                fi
            fi
        done <"$env_example_path"

        greenprint "$selected_service environment variables saved to $env_file."
    else
        yellowprint "No .env.example file found for $selected_service. Skipping environment variable configuration."
    fi
else
    yellowprint "Skipping environment variable setup."
fi
