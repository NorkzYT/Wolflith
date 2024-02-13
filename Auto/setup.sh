#!/bin/bash

# Source the PersonalizationFunctions for color support
source PCSMenu/Functions/PersonalizationFunctions.sh

# Install all dependencies
install_dependencies() {
    blueprint "Installing dependencies..."
    ./Auto/dependencies.sh
    greenprint "Dependencies installed."
    echo ""
}

# Configure Hashicorp Vault
configure_vault() {
    blueprint "Configuring Hashicorp Vault..."
    read -p "Do you have a Hashicorp Vault docker container setup? (y/n): " vault_setup
    if [[ $vault_setup =~ ^[Yy]$ ]]; then
        while true; do
            read -p "What is the address of the Vault server? (Starts with https://): " vault_address
            if [[ $vault_address =~ ^https:// ]]; then
                break
            else
                redprint "The address must start with https://. Please try again."
            fi
        done

        read -p "What is the secret name in the secret engine?: " secret_name

        sed -i'' "s#https://hashicorp-vault.domain.com#$vault_address#g" ./Scripts/Vault/vault-pull.go
        sed -i'' "s/NAME/$secret_name/g" ./Scripts/Vault/vault-pull.go
        sed -i'' "s#https://hashicorp-vault.domain.com#$vault_address#g" ./Scripts/Vault/vault-push.go
        sed -i'' "s/NAME/$secret_name/g" ./Scripts/Vault/vault-push.go

        greenprint "Vault configuration updated."
    else
        yellowprint "Skipping Vault setup."
    fi
    echo ""
}

# Function to prompt for directory location
prompt_directory_location() {
    blueprint "Checking for saved directory location..."
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
    local saved_dir_location="$script_dir/../Scripts/directory_location.txt"

    if [ -f "$saved_dir_location" ]; then
        directory_location=$(cat "$saved_dir_location")
        if [ -z "$directory_location" ] || [ ! -d "$directory_location" ]; then
            redprint "Saved directory location is invalid. Please enter a new directory location."
        else
            greenprint "Using saved directory location: $directory_location"
            return
        fi
    fi

    read -p "Enter the directory location of the Wolflith repository: " directory_location
    if [ ! -d "$directory_location" ]; then
        redprint "Directory '$directory_location' does not exist."
        exit 1
    fi
    greenprint "Directory validated: $directory_location"
    echo "$directory_location" >"$directory_location/Wolflith/Scripts/directory_location.txt"
}

# Update execute permissions
update_permissions() {
    blueprint "Updating execute permissions for .sh files..."
    local sh_files=$(find "$directory_location/Wolflith" -name "*.sh")

    for file in $sh_files; do
        chmod +x "$file"
    done

    greenprint "Execute permissions updated."
}

# Update PCSMenu and Makefile locations
update_config_locations() {
    blueprint "Updating PCSMenu and Makefile with the new directory location..."
    sed -i'' "s#/home/user#$directory_location#g" "$directory_location/Wolflith/Makefile"

    find "$directory_location/Wolflith/PCSMenu" -type f -exec sed -i'' "s#/home/user#$directory_location#g" {} \;

    greenprint "PCSMenu and Makefile locations updated."
}

# Modify Docker Compose files
modifyComposeFiles() {
    "$directory_location/Wolflith/Auto/modifyComposeFiles.sh" "$directory_location"
}

# Setup Docker Environment files
dockerEnvSetup() {
    "$directory_location/Wolflith/Auto/environmentSetup.sh" "$directory_location"
}

# Main function to coordinate the setup process
main() {
    cyanprint "Starting Wolflith setup..."
    install_dependencies
    prompt_directory_location
    configure_vault
    update_permissions
    update_config_locations
    modifyComposeFiles
    dockerEnvSetup
    blueprint "Before provisioning any Docker services, you have the opportunity to customize the environment settings. This can be done by modifying the .env file located in the respective docker service's folder."
    blueprint "Please ensure to review and adjust the .env file as needed to suit your specific configuration requirements prior to initiating the provisioning process."
    echo ""
    greenprint "Wolflith setup completed successfully."
}

# Invoke the main function to start the setup process
main
