#!/bin/bash

# Source the PersonalizationFunctions for color support
source /opt/Wolflith/PCSMenu/src/Color.sh

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
        env_file="/opt/Wolflith/.env"

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

        # Pull environmental variables from Vault
        read -rp "Do you want to pull environmental variables from the Vault now? (y/n): " pull_vars
        if [[ $pull_vars =~ ^[Yy]$ ]]; then
            # Navigate to the script's directory and run the Go script
            (cd /opt/Wolflith/Scripts/Vault && go run main.go -action pull)
            if [ $? -eq 0 ]; then
                greenprint "Successfully pulled environmental variables from Vault."
            else
                redprint "Failed to pull environmental variables from Vault."
            fi
        else
            yellowprint "Skipping pulling environmental variables from Vault."
        fi
    else
        yellowprint "Skipping Vault setup."
    fi
    echo ""
}

# Modify Docker Compose files
modifyComposeFiles() {
    "/opt/Wolflith/Auto/modifyComposeFiles.sh" "/opt/Wolflith"
}

# Build PCSMenu with Cargo
build_PCSMenu() {
    blueprint "Building PCSMenu with Cargo..."
    export PATH="$PATH:$HOME/.cargo/bin"
    pushd /opt/Wolflith/PCSMenu || exit
    if cargo build --release; then
        greenprint "PCSMenu built successfully."
    else
        redprint "Failed to build PCSMenu."
        exit 1
    fi
    popd || exit
    echo ""
}

# Setup Environment files
EnvSetup() {
    "/opt/Wolflith/Auto/environmentSetup.sh" "/opt/Wolflith"
}

# Main function to coordinate the setup process
main() {
    # Ensure the Temp directory exists
    mkdir -p Temp
    cyanprint "Starting Wolflith setup..."
    install_dependencies
    EnvSetup
    build_PCSMenu
    configure_vault
    modifyComposeFiles
    blueprint "Before provisioning any Docker services, you have the opportunity to customize the environment settings. This can be done by modifying the .env file located in the respective docker service's folder."
    blueprint "Please ensure to review and adjust the .env file as needed to suit your specific configuration requirements prior to initiating the provisioning process."
    echo ""
    greenprint "Wolflith setup completed successfully."
}

# Invoke the main function to start the setup process
main
