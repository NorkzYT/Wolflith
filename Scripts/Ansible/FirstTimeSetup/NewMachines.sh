#!/bin/bash

# Read the directory location from the directory_location.txt file
DIRECTORY_LOCATION=$(cat Scripts/directory_location.txt)
HOSTS_FILE="$DIRECTORY_LOCATION/Wolflith/Ansible/inventory/hosts.yaml"

# Ensure the initial structure of the YAML file if not present
if [ ! -f "$HOSTS_FILE" ]; then
    echo "hosts.yaml file not found at $HOSTS_FILE."
    exit 1
fi

# Check for yq and install if not present
if ! command -v yq &>/dev/null; then
    echo "yq could not be found, attempting to install..."

    # Detect system architecture
    ARCH=$(uname -m)
    case $ARCH in
    x86_64) YQ_BIN="yq_linux_amd64" ;;
    aarch64) YQ_BIN="yq_linux_arm64" ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
    esac

    # Download and install yq
    wget "https://github.com/mikefarah/yq/releases/latest/download/$YQ_BIN" -O /usr/local/bin/yq &&
        chmod +x /usr/local/bin/yq

    if ! command -v yq &>/dev/null; then
        echo "Failed to install yq. Please install it manually."
        exit 1
    fi
fi

# Function to list machines from hosts.yaml using yq
list_machines() {
    echo "Machines listed in hosts.yaml:"
    yq e '.all.children.*.hosts | keys | .[]' "$HOSTS_FILE"
}

# Prompt user to choose running for all machines or select one
list_machines
echo "Do you want to run the playbooks for all machines listed in hosts.yaml? (y/n)"
read -r run_for_all

# Adjusting the selection process for running against all machines or a specific one
if [[ "$run_for_all" =~ ^[Yy]$ ]]; then
    LIMIT_OPTION="" # No limit, run against all machines
else
    echo "Enter the name of the machine you want to run the playbooks for:"
    read -r machine_name
    LIMIT_OPTION="--limit $machine_name" # Limit to the selected machine
fi

# Define a function to run ansible playbooks with limit option if applicable
run_playbook() {
    playbook=$1
    echo "Running playbook: $playbook"
    ansible-playbook "$DIRECTORY_LOCATION/Wolflith/Ansible/playbooks/$playbook.yml" -i "$HOSTS_FILE" $LIMIT_OPTION
}

# List of playbooks to be executed
declare -a playbooks=("apt" "timezone" "fail2ban" "user-dir")

# Run the playbooks
for playbook in "${playbooks[@]}"; do
    run_playbook "$playbook"
done

# Install required collections
ansible-galaxy install -r "$DIRECTORY_LOCATION/Wolflith/Ansible/collections/requirements.yml" $INVENTORY_OPTION

# Additional playbooks that require special handling or roles
run_playbook "oh-my-zsh"
run_playbook "git-repo-pull"
run_playbook "add-execute-permission"

echo "All specified playbooks have been executed successfully."
