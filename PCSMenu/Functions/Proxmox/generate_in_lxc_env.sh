#!/bin/bash

# Script to generate .env file from .env.example and values in env_vars_for_ansible.yml

# Define paths
env_example_path="/home/docker/$1/.env.example"
env_vars_path="/tmp/env_vars_for_ansible.yml"
output_env_path="/home/docker/$1/.env"

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
