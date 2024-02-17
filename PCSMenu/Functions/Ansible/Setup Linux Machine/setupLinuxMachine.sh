#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/wolflith/PCSMenu/PCSFunc.sh

HOSTS_FILE="/opt/wolflith/Ansible/inventory/hosts.yaml"

## ----------------------------------------------------------------------------------------------------------- ##

function new_machine_setup() {
    default_menu_screen
    printf "This script is an automation tool that runs several Ansible playbooks in order to set up a new Linux Machine. The playbooks perform various tasks such as updating the package cache and installed packages, configuring time synchronization, installing and configuring the fail2ban package, creating a user on the host machine, and setting up Oh-My-Zsh on the host machine.\n"
    echo ""
    while true; do
        read -p "Do you still want to run this command? (yes/no) " run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            execute_ansible_playbooks

            # Prompt at the end
            echo "Press any key to continue..."
            read -n 1 -r
            clear

            # Call the ansible_menu function
            ansible_menu

            break
        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            ansible_menu
            return
        else
            invalid_answer
            clear
            menu_cover
            new_machine_setup
        fi
    done
}

## ----------------------------------------------------------------------------------------------------------- ##

execute_ansible_playbooks() {
    # Ensure the initial structure of the YAML file if not present
    if [ ! -f "$HOSTS_FILE" ]; then
        redprint "hosts.yaml file not found at $HOSTS_FILE."
        exit 1
    fi

    # Check for yq and install if not present
    if ! command -v yq &>/dev/null; then
        yellowprint "yq could not be found, attempting to install..."

        # Detect system architecture
        ARCH=$(uname -m)
        case $ARCH in
        x86_64) YQ_BIN="yq_linux_amd64" ;;
        aarch64) YQ_BIN="yq_linux_arm64" ;;
        *)
            redprint "Unsupported architecture: $ARCH"
            exit 1
            ;;
        esac

        # Download and install yq
        if wget "https://github.com/mikefarah/yq/releases/latest/download/$YQ_BIN" -O /usr/local/bin/yq && chmod +x /usr/local/bin/yq; then
            greenprint "yq installed successfully."
        else
            redprint "Failed to install yq. Please install it manually."
            exit 1
        fi
    fi

    # Function to list machines from hosts.yaml using yq
    list_machines() {
        greenprint "Machines listed in hosts.yaml:"
        yq e '.all.children.*.hosts | keys | .[]' "$HOSTS_FILE"
    }

    # Prompt user to choose running for all machines or select one
    list_machines
    yellowprint "Do you want to run the playbooks for all machines listed in hosts.yaml? (y/n)"
    read -r run_for_all

    # Adjusting the selection process for running against all machines or a specific one
    if [[ "$run_for_all" =~ ^[Yy]$ ]]; then
        LIMIT_OPTION="" # No limit, run against all machines
    else
        cyanprint "Enter the name of the machine you want to run the playbooks for:"
        read -r machine_name
        LIMIT_OPTION="--limit $machine_name" # Limit to the selected machine
    fi

    # Define a function to run ansible playbooks with limit option if applicable
    run_playbook() {
        local playbook=$1
        blueprint "Running playbook: $playbook"
        if ! ansible-playbook "/opt/wolflith/Ansible/playbooks/$playbook.yml" -i "$HOSTS_FILE" $LIMIT_OPTION; then
            redprint "Failed to execute playbook: $playbook"
            return 1
        fi
    }

    # List of playbooks to be executed
    declare -a playbooks=("apt" "timezone" "fail2ban" "user-dir")

    # Run the playbooks
    for playbook in "${playbooks[@]}"; do
        if ! run_playbook "$playbook"; then
            break # Exit if a playbook fails to ensure error handling
        fi
    done

    # Additional playbooks that require special handling or roles
    if ! run_playbook "oh-my-zsh"; then
        redprint "Failed to execute oh-my-zsh playbook."
        exit 1
    fi

    greenprint "All specified playbooks have been executed successfully."
}

new_machine_setup
