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

    # Ask for the secret name in the secret engine
    read -p "What is the secret name that is in the secret engine?: " secret_name

    # Replace https://hashicorp-vault.domain.com with the user-provided Vault server address in vault-pull.go
    sed -i'' "s#https://hashicorp-vault.domain.com#$vault_address#g" ./Scripts/Vault/vault-pull.go

    # Replace NAME with the user-provided secret name in vault-pull.go
    sed -i'' "s/NAME/$secret_name/g" ./Scripts/Vault/vault-pull.go

    # Replace https://hashicorp-vault.domain.com with the user-provided Vault server address in vault-push.go
    sed -i'' "s#https://hashicorp-vault.domain.com#$vault_address#g" ./Scripts/Vault/vault-push.go

    # Replace NAME with the user-provided secret name in vault-push.go
    sed -i'' "s/NAME/$secret_name/g" ./Scripts/Vault/vault-push.go

    echo "vault-pull.go and vault-push.go has been updated with the new Vault server address and the secret name."

else
    echo "Skipping Vault setup."
    echo ""
fi

# Prompt user for the directory location of the Wolflith GitHub repository
read -p "Enter the directory location of the Wolflith repository: (e.g. /home/user)" directory_location

# Validate the directory location
if [ ! -d "$directory_location/Wolflith" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

# Check if the location exists
if ! [[ -d "$directory_location/Wolflith" ]]; then
    echo "Directory '$directory_location/Wolflith' does not exist."
    exit 1
fi

# Save the directory location
echo "$directory_location" >$directory_location/Wolflith/Scripts/directory_location.txt

# Find all .sh files in the specified directory
sh_files=$(find "$directory_location/Wolflith" -name "*.sh")

# Iterate through each .sh file
for file in $sh_files; do
    # Add execute permission to the file
    chmod +x "$file"
done

echo ""
echo "Execute permissions have been granted to all .sh files in '$directory_location/Wolflith'."
echo ""


echo "Updating PCSMenu files with the new directory location."

# Update the Makefile with the new directory location
sed -i'' "s#/home/user#$directory_location#g" Makefile

echo "Makefile updated with the new directory location."

# Replace /home/user with the user-provided directory location in all files in the PCSMenu folder
find $directory_location/Wolflith/PCSMenu -type f -exec sed -i "s#/home/user#$directory_location#g" {} \;

echo "PCSMenu files updated with the new directory location."

echo ""

"$directory_location/Wolflith/Auto/update_env_vars.sh" "$directory_location"