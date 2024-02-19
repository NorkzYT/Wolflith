#!/bin/bash

# Source the PersonalizationFunctions for color support
source /opt/wolflith/PCSMenu/PersonalizationFunc.sh

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
    read -rp "Do you have and want to use a Hashicorp Vault server? (y/n): " vault_setup
    if [[ $vault_setup =~ ^[Yy]$ ]]; then
        env_file="/opt/wolflith/.env"

        # Check if the Vault address is already set
        if grep -q "^HASHICORP_VAULT_ADDRESS='https://" "$env_file"; then
            current_address=$(grep "^HASHICORP_VAULT_ADDRESS=" "$env_file" | cut -d"'" -f2)
            read -rp "Vault address ($current_address) found. Use it? (y/n): " use_existing_address
            if [[ $use_existing_address =~ ^[Nn]$ ]]; then
                while true; do
                    read -rp "Enter new Vault server address (Starts with https://): " vault_address
                    if [[ $vault_address =~ ^https:// ]]; then
                        sed -i'' -e "s#^HASHICORP_VAULT_ADDRESS=.*#HASHICORP_VAULT_ADDRESS='$vault_address'#" "$env_file"
                        break
                    else
                        redprint "The address must start with https://. Please try again."
                    fi
                done
            fi
        else
            while true; do
                read -rp "Enter the Vault server address (Starts with https://): " vault_address
                if [[ $vault_address =~ ^https:// ]]; then
                    echo "HASHICORP_VAULT_ADDRESS='$vault_address'" >>"$env_file"
                    break
                else
                    redprint "The address must start with https://. Please try again."
                fi
            done
        fi

        # Check if the Vault username is already set
        if grep -q "^HASHICORP_USER_NAME=" "$env_file"; then
            current_username=$(grep "^HASHICORP_USER_NAME=" "$env_file" | cut -d"'" -f2)
            read -rp "Vault username ($current_username) found. Use it? (y/n): " use_existing_username
            if [[ $use_existing_username =~ ^[Nn]$ ]]; then
                read -rp "Enter new Vault username: " vault_username
                sed -i'' -e "s#^HASHICORP_USER_NAME=.*#HASHICORP_USER_NAME='$vault_username'#" "$env_file"
            fi
        else
            read -rp "Enter the Vault username: " vault_username
            echo "HASHICORP_USER_NAME='$vault_username'" >>"$env_file"
        fi

        # Check if the Vault password is already set
        if grep -q "^HASHICORP_PASSWORD=" "$env_file"; then
            read -rsp "Existing Vault password found. Enter a new password (leave blank to keep existing): " vault_password
            echo
            if [[ $vault_password ]]; then
                sed -i'' -e "s#^HASHICORP_PASSWORD=.*#HASHICORP_PASSWORD='$vault_password'#" "$env_file"
            fi
        else
            read -rsp "Enter the Vault password: " vault_password
            echo
            echo "HASHICORP_PASSWORD='$vault_password'" >>"$env_file"
        fi

        greenprint "Vault configuration updated in .env file."
    else
        yellowprint "Skipping Vault setup."
    fi
    echo ""
}

# Modify Docker Compose files
modifyComposeFiles() {
    "/opt/wolflith/Auto/modifyComposeFiles.sh" "/opt/wolflith"
}

# Setup Environment files
EnvSetup() {
    "/opt/wolflith/Auto/environmentSetup.sh" "/opt/wolflith"
}

# Main function to coordinate the setup process
main() {
    cyanprint "Starting wolflith setup..."
    install_dependencies
    EnvSetup
    configure_vault
    modifyComposeFiles
    blueprint "Before provisioning any Docker services, you have the opportunity to customize the environment settings. This can be done by modifying the .env file located in the respective docker service's folder."
    blueprint "Please ensure to review and adjust the .env file as needed to suit your specific configuration requirements prior to initiating the provisioning process."
    echo ""
    greenprint "wolflith setup completed successfully."
}

# Invoke the main function to start the setup process
main
