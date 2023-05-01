#!/bin/bash

# This script does the following:

#Sets the variable VAULT_ADDR to a specific URL.
#Prompts the user for their username and password and stores the input in the variables username and password, respectively.
#Uses the docker command to authenticate to Hashicorp Vault using the client token authentication method and the provided username and password.
#Finds all files with the .env.example extension in the current directory and its subdirectories and copies each file to a new file with the same name but with a .env extension, if a file with that name does not already exist.
#Finds all files with the .env extension in the current directory and its subdirectories and reads their contents into an array called env_vars, filtering out lines that start with a # (comments) or are empty.
#Loops through the array env_vars and for each element, it splits the element into a name and value field using the = character as a delimiter. It assigns the name field to the variable name and the value field to the variable value.
#Uses the docker command to push the environmental variable name and its value value into Hashicorp Vault using the kv patch command.

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

        # Push environmental variable and its value into Hashicorp Vault
        docker exec vault-server vault kv patch kv/name "$name"="$value"
    done
done

# ------------------------------------------------------------------------------------------------------ #
