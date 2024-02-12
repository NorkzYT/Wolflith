#!/bin/bash

source Functions/PersonalizationFunctions.sh

# Default values
default_vCPU=2
default_RAM=2048  # in MB
default_Storage=6 # in GB
default_storage_name="local"
default_ct_storage="local"
default_api_user="root"
default_node="pve"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DIRECTORY_LOCATION=$(cat "$SCRIPT_DIR/../../../Scripts/directory_location.txt")
SELECTED_SERVICE=$(cat /tmp/selected_docker_service.txt)

# Use color functions to print headers and information
blueprint "Configuration for Proxmox LXC Provisioning"

# Prompt for Proxmox API details with defaults
greenprint "Enter Proxmox VE API host (e.g, 24.156.99.202 [WAN IP]): "
read api_host

greenprint "Enter Proxmox VE API user (default: $default_api_user): "
read api_user
api_user=${api_user:-$default_api_user}

greenprint "Enter Proxmox VE API password: "
read -sp "" api_password
echo ""

greenprint "Enter Proxmox VE node name (default: $default_node): "
read node
node=${node:-$default_node}

greenprint "Use default specifications? (vCPU: $default_vCPU, RAM: $default_RAM MB, lxc_storage_amount: $default_Storage GB) [Y/n] "
read use_defaults
if [[ "$use_defaults" =~ ^[Nn] ]]; then
    greenprint "Enter number of vCPU: "
    read vCPU
    greenprint "Enter RAM size in MB: "
    read RAM
    greenprint "Enter storage size in GB: "
    read lxc_storage_amount
else
    vCPU=$default_vCPU
    RAM=$default_RAM
    lxc_storage_amount=$default_Storage
fi

greenprint "Enter storage name for VM disk (default: $default_storage_name): "
read lxc_storage_name
lxc_storage_name=${lxc_storage_name:-$default_storage_name}

greenprint "Enter the name of the storage that contains CT Templates (default: $default_ct_storage): "
read ct_storage
ct_storage=${ct_storage:-$default_ct_storage}

greenprint "Enter root password for LXC: "
read -sp "" lxc_root_password
echo ""

# Additional questions based on the Proxmox Ansible docs
cyanprint "The default hostname will be the service you selected to install: $SELECTED_SERVICE"
greenprint "Would you like to define a custom hostname suffix or leave empty to use default? [Enter suffix or leave blank]: "
read hostname_suffix
if [ -z "$hostname_suffix" ]; then
    hostname="${SELECTED_SERVICE}"
else
    hostname="${SELECTED_SERVICE}${hostname_suffix}"
fi
hostname=$(echo "$hostname" | tr '[:upper:]' '[:lower:]') # Convert to lowercase

cyanprint "Network interface configuration:"
ip_config="dhcp"
greenprint "Use DHCP or static IP? [dhcp/static]: "
read ip_config_choice
if [[ "$ip_config_choice" == "static" ]]; then
    greenprint "Enter static IP address (e.g., 192.168.1.100/24): "
    read ip_address
    greenprint "Enter gateway IP address (e.g., 192.168.0.1): "
    read gw_ip
    ip_config="{'net0':'name=eth0,gw=$gw_ip,ip=$ip_address,bridge=vmbr0'}"
else
    ip_config="{'net0':'name=eth0,ip=dhcp,bridge=vmbr0'}"
fi

# Create a YAML file with all the variables to pass to the Ansible playbook
cat <<EOF >/tmp/lxc_provisioning_vars.yml
api_host: "$api_host"
api_password: "$api_password"
api_user: "${api_user}@pam"
hostname: "$hostname"
node: "$node"
vCPU: $vCPU
RAM: $RAM
lxc_storage_amount: $lxc_storage_amount
lxc_storage_name: "$lxc_storage_name"
lxc_root_password: "$lxc_root_password"
ct_storage: "$ct_storage"
netif: "$ip_config"
EOF

yellowprint "Provisioning variables saved to /tmp/lxc_provisioning_vars.yml."
