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

# Update execute permissions
update_permissions() {
    blueprint "Updating execute permissions for .sh files..."
    local sh_files=$(find "/opt/wolflith" -name "*.sh")

    for file in $sh_files; do
        chmod +x "$file"
    done

    greenprint "Execute permissions updated."
}

# Modify Docker Compose files
modifyComposeFiles() {
    "/opt/wolflith/Auto/modifyComposeFiles.sh" "/opt"
}

# Setup Docker Environment files
dockerEnvSetup() {
    "/opt/wolflith/Auto/environmentSetup.sh" "/opt"
}

# Main function to coordinate the setup process
main() {
    cyanprint "Starting wolflith setup..."
    install_dependencies
    configure_vault
    update_permissions
    modifyComposeFiles
    dockerEnvSetup
    blueprint "Before provisioning any Docker services, you have the opportunity to customize the environment settings. This can be done by modifying the .env file located in the respective docker service's folder."
    blueprint "Please ensure to review and adjust the .env file as needed to suit your specific configuration requirements prior to initiating the provisioning process."
    echo ""
    greenprint "wolflith setup completed successfully."
}

# Invoke the main function to start the setup process
main
