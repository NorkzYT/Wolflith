#!/bin/bash

# Install all Dependencies needed.
./Auto/dependencies.sh

echo ""

# Ask if the user has a Hashicorp Vault docker container setup
read -p "Do you have a Hashicorp Vault docker container setup? (y/n): " vault_setup
if [[ $vault_setup = "Y" ]] || [[ $vault_setup = "y" ]]; then
    # Ask for the Vault server address
    while true; do
        read -p "What is the address of the Vault server? (Starts with https://): " vault_address
        if [[ $vault_address = https://* ]]; then
            break
        else
            echo "The address must start with https://. Please try again."
        fi
    done

    # Ask for the hostname of the docker container for the Vault
    read -p "What is the hostname of the docker container for the Vault?: " vault_hostname

    # Ask for the secret name in the secret engine
    read -p "What is the secret name that is in the secret engine?: " secret_name

    # Replace HASHICORP-VAULT-HOSTNAME with the user-provided hostname in auto-pull-env.sh
    sed -i "s/HASHICORP-VAULT-HOSTNAME/$vault_hostname/g" ./Scripts/Vault/auto-pull-env.sh

    # Replace https://hashicorp-vault.domain.com with the user-provided Vault server address in auto-pull-env.sh
    sed -i "s#https://hashicorp-vault.domain.com#$vault_address#g" ./Scripts/Vault/auto-pull-env.sh

    # Replace NAME with the user-provided secret name in auto-pull-env.sh
    sed -i "s/NAME/$secret_name/g" ./Scripts/Vault/auto-pull-env.sh

    # Replace HASHICORP-VAULT-HOSTNAME with the user-provided hostname in auto-push-env.sh
    sed -i "s/HASHICORP-VAULT-HOSTNAME/$vault_hostname/g" ./Scripts/Vault/auto-push-env.sh

    # Replace https://hashicorp-vault.domain.com with the user-provided Vault server address in auto-push-env.sh
    sed -i "s#https://hashicorp-vault.domain.com#$vault_address#g" ./Scripts/Vault/auto-push-env.sh

    # Replace NAME with the user-provided secret name in auto-push-env.sh
    sed -i "s/NAME/$secret_name/g" ./Scripts/Vault/auto-push-env.sh


    echo "auto-pull-env.sh updated with the new Vault server address and hostname."

else
    echo "Skipping Vault setup."
    echo ""
fi

# Prompt user for the directory location of the Launchpad GitHub repository
read -p "Enter the directory location of the Launchpad repository: (e.g. /home)" directory_location

# Validate the directory location
if [ ! -d "$directory_location/Launchpad" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

# Check if the location exists
if ! [[ -d "$directory_location/Launchpad" ]]; then
    echo "Directory '$directory_location/Launchpad' does not exist."
    exit 1
fi

# Find all .sh files in the specified directory
sh_files=$(find "$directory_location/Launchpad" -name "*.sh")

# Iterate through each .sh file
for file in $sh_files; do
    # Add execute permission to the file
    chmod +x "$file"
done

echo ""
echo "Execute permissions have been granted to all .sh files in '$directory_location/Launchpad'."
echo ""


echo "Updating PCSMenu files with the new directory location."

# Save the directory location
echo "$directory_location" >$directory_location/Launchpad/Scripts/directory_location.txt

# Update the Makefile with the new directory location
sed -i'' "s#/home/user#$directory_location#g" Makefile

echo "Makefile updated with the new directory location."

# Replace /home/user with the user-provided directory location in all files in the PCSMenu folder
find $directory_location/Launchpad/PCSMenu -type f -exec sed -i "s#/home/user#$directory_location#g" {} \;

echo "PCSMenu files updated with the new directory location."

echo ""

"$directory_location/Launchpad/Auto/update_env_vars.sh" "$directory_location"