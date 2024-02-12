#!/bin/bash

source Functions/PersonalizationFunctions.sh

DIRECTORY_LOCATION=$(cat ../Scripts/directory_location.txt)
HOSTS_FILE="$DIRECTORY_LOCATION/Wolflith/Ansible/inventory/hosts.yaml"
SSH_KEY_DIR="/root/.ssh/ansible_keys"

initialize_yaml_structure() {
    if [ ! -f "$HOSTS_FILE" ]; then
        greenprint "Initializing YAML structure..."
        echo "all:" >"$HOSTS_FILE"
        echo "  children:" >>"$HOSTS_FILE"
    fi
}

check_group_exists() {
    grep -q "    $1:" "$HOSTS_FILE"
}

append_machine_to_existing_group() {
    local group_name=$1
    local machine_name=$2
    local ip_address=$3
    local port=$4

    local last_host_line=$(awk "/    $group_name:/,/      vars:|  children:/{if(/        [a-zA-Z0-9_]+:/) last=NR} END {print last}" "$HOSTS_FILE")

    if [ -n "$last_host_line" ] && [[ "$last_host_line" -gt 0 ]]; then
        greenprint "Adding $machine_name to $group_name..."
        sed -i "$((last_host_line + 1))i \        $machine_name:\n          ansible_host: $ip_address\n          ansible_port: $port" "$HOSTS_FILE"
    else
        redprint "Error: Could not determine the appropriate location to insert the new machine within '$group_name'."
        return 1
    fi
}

append_group_with_vars() {
    local group_name=$1
    local ansible_user=$2
    local auth_method=$3
    local auth_value=$4

    greenprint "Appending new group $group_name with vars..."
    echo "    $group_name:" >>"$HOSTS_FILE"
    echo "      hosts:" >>"$HOSTS_FILE"
    echo "        $machine_name:" >>"$HOSTS_FILE"
    echo "          ansible_host: $ip_address" >>"$HOSTS_FILE"
    echo "          ansible_port: $port" >>"$HOSTS_FILE"
    echo "      vars:" >>"$HOSTS_FILE"
    echo "        ansible_user: $ansible_user" >>"$HOSTS_FILE"
    echo "        ansible_connection: ssh" >>"$HOSTS_FILE"
    echo "        host_key_checking: False" >>"$HOSTS_FILE"
    if [ "$auth_method" == "ssh" ]; then
        echo "        ansible_ssh_private_key_file: $auth_value" >>"$HOSTS_FILE"
    elif [ "$auth_method" == "password" ]; then
        echo "        ansible_ssh_pass: $auth_value" >>"$HOSTS_FILE"
        echo "        ansible_become_pass: $auth_value" >>"$HOSTS_FILE"
    fi
}

main() {
    mkdir -p "$(dirname "$HOSTS_FILE")"
    initialize_yaml_structure

    read -p "Enter the group name (e.g., ProxmoxVE): " group_name
    if check_group_exists "$group_name"; then
        blueprint "Adding machine to existing group: $group_name"
        read -p "Enter the machine name (e.g., Machine1): " machine_name
        read -p "Enter the IP address of the machine: " ip_address
        read -p "Enter the port number for SSH: " port
        append_machine_to_existing_group "$group_name" "$machine_name" "$ip_address" "$port"
    else
        blueprint "Creating new group: $group_name"
        append_group_with_vars_logic "$group_name"
    fi
}

append_group_with_vars_logic() {
    read -p "Enter the machine name (e.g., Machine1): " machine_name
    read -p "Enter the IP address of the machine: " ip_address
    read -p "Enter the port number for SSH: " port
    read -p "Enter the Ansible SSH username: " ansible_user

    local auth_method
    local auth_value
    while true; do
        read -p "Will you use an SSH key or password for authentication? (ssh/password): " auth_method
        case "$auth_method" in
        ssh)
            mkdir -p "$SSH_KEY_DIR"
            auth_value="$SSH_KEY_DIR/$machine_name"

            if [ -f "$auth_value" ]; then
                greenprint "SSH key for $machine_name already exists at $auth_value."
            else
                yellowprint "SSH key for $machine_name does not exist at $auth_value."
                while true; do
                    read -p "Do you have a private key for the machine? (y/n): " yn
                    case "$yn" in
                    [Yy]*)
                        read -p "Enter the path to your SSH key: " ssh_key_path
                        if [[ "$ssh_key_path" != "$auth_value" ]]; then
                            cp "$ssh_key_path" "$auth_value"
                        fi
                        break
                        ;;
                    [Nn]*)
                        cyanprint "Please provide the $machine_name ssh private key content (paste below and press Ctrl-D when finished):"
                        cat >"$auth_value"
                        break
                        ;;
                    *) redprint "Please answer yes (y) or no (n)." ;;
                    esac
                done
                chmod 600 "$auth_value"
            fi
            break
            ;;
        password)
            read -s -p "Enter the SSH password: " ssh_password
            echo
            auth_value="$ssh_password"
            break
            ;;
        *) redprint "Invalid authentication method selected. Please answer ssh or password." ;;
        esac
    done

    append_group_with_vars "$group_name" "$ansible_user" "$auth_method" "$auth_value"
}

main
