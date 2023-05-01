#!/bin/bash

# This script does the following:

#Prompts the user for a username and password and uses them to authenticate to Hashicorp Vault.
#Finds all .env.example files in the current directory and its subdirectories and creates a copy of each file with the name .env. If a .env file with the same name already exists, it will skip it and move on to the next file.
#Finds all .env files in the current directory and its subdirectories and reads their contents into an array, filtering out comments and empty lines.
#Loops through the array of environment variables and splits each one into a name and value field using the "=" character as a delimiter.
#For each name and value, the script checks if the variable is in Hashicorp Vault and retrieves its corresponding secret value.
#If the secret value is not "null" and the value field of the environment variable is an empty string, the script replaces the line in the .env file with the secret value from Vault. Otherwise, it does nothing.

# Set variables
VAULT_ADDR=https://vault.domain.com

# Prompt user for username and password
read -p "Username: " username
read -sp "Password: " password
echo

# Authenticate to Vault using client token
docker exec -d vault-server vault login -method=userpass username=$username password=$password

# ------------------------------------------------------------------------------------------------------ #

# This command will find all .env.example files in the current directory and its subdirectories,
# and for each file it will check if a .env file with the same name already exists. If it doesn't,
# it will copy the contents of the .env.example file into a new .env file in the same folder.
# If the .env file does exist, it will skip it and move on to the next file.
find . -name "*.env.example" -exec sh -c 'for file; do if [ ! -e "${file%.env.example}.env" ]; then cp "$file" "${file%.env.example}.env"; fi; done' sh {} +

# Find all .env files
for env_file in $(find . -name "*.env"); do
    # Read .env file into an array, filtering out comments and empty lines
    mapfile -t env_vars < <(grep -v '^#\|^$' "$env_file")

    # Loop through array of environment variables
    for env_var in "${env_vars[@]}"; do
        # Split input string into array
        IFS="=" read -ra parts <<<"$env_var"

        # Assign values to variables
        name=$(echo "$env_var" | cut -d '=' -f 1)
        value=$(echo "$env_var" | cut -d '=' -f 2)

        # Check if variable is in Vault
        secret=$(docker exec vault-server vault kv get -field=$name kv/name)

        # Check if value is not "null" and if it is an empty string
        if [ "$secret" != "null" ] && [ -z "$value" ]; then
            # Replace line in .env file with secret from Vault
            echo "--------------------------------------------------------------------------------"
            sed -i "s/^$name=.*$/$name=$secret/" "$env_file"
        else
            echo "--------------------------------------------------------------------------------"
        fi
    done
done

# ------------------------------------------------------------------------------------------------------ #
