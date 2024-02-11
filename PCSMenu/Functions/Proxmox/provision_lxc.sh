#!/bin/bash

# Default values
default_vCPU=2
default_RAM=2048  # in MB
default_Storage=6 # in GB
default_storage_name="local"
default_ct_storage="local"
default_network_name="proxy"
default_appdata_location="/mnt/appdata"
default_api_user="root"
default_node="pve"

DIRECTORY_LOCATION=$(cat "$SCRIPT_DIR/../../../Scripts/directory_location.txt")
SELECTED_SERVICE=$(cat /tmp/selected_docker_service.txt)
SELECTED_SERVICE_PATH=$(cat /tmp/selected_docker_service_path.txt)

# Prompt for Proxmox API details with defaults
read -p "Enter Proxmox VE API host (e.g, 24.156.99.202 [WAN IP]): " api_host

read -p "Enter Proxmox VE API user (default: $default_api_user): " api_user
api_user=${api_user:-$default_api_user}

read -sp "Enter Proxmox VE API password: " api_password
echo ""
read -p "Enter Proxmox VE node name (default: $default_node): " node
node=${node:-$default_node}

read -p "Use default specifications? (vCPU: $default_vCPU, RAM: $default_RAM MB, lxc_storage_amount: $default_Storage GB) [Y/n] " use_defaults
if [[ "$use_defaults" =~ ^[Nn] ]]; then
    read -p "Enter number of vCPU: " vCPU
    read -p "Enter RAM size in MB: " RAM
    read -p "Enter storage size in GB: " lxc_storage_amount
else
    vCPU=$default_vCPU
    RAM=$default_RAM
    lxc_storage_amount=$default_Storage
fi

read -p "Enter storage name for VM disk (default: $default_storage_name): " lxc_storage_name
lxc_storage_name=${lxc_storage_name:-$default_storage_name}

read -p "Enter the name of the storage that contains CT Templates (default: $default_ct_storage): " ct_storage
ct_storage=${ct_storage:-$default_ct_storage}

read -sp "Enter root password for LXC: " lxc_root_password
echo ""
read -p "Change Docker Network name from default 'proxy'? [y/N] " change_network_name
if [[ "$change_network_name" =~ ^[Yy] ]]; then
    read -p "Enter new Docker Network name: " network_name
else
    network_name=$default_network_name
fi

read -p "Change appdata location from default '$default_appdata_location'? [y/N] " change_appdata_location
if [[ "$change_appdata_location" =~ ^[Yy] ]]; then
    read -p "Enter new appdata location: " appdata_location
else
    appdata_location=$default_appdata_location
fi

# Additional questions based on the Proxmox Ansible docs
echo "The default hostname will be the service you selected to install: $SELECTED_SERVICE"
read -p "Would you like to define a custom hostname suffix or leave empty to use default? [Enter suffix or leave blank]: " hostname_suffix
if [ -z "$hostname_suffix" ]; then
    hostname="${SELECTED_SERVICE}"
else
    hostname="${SELECTED_SERVICE}${hostname_suffix}"
fi
hostname=$(echo "$hostname" | tr '[:upper:]' '[:lower:]') # Convert to lowercase

echo "Network interface configuration:"
ip_config="dhcp"
read -p "Use DHCP or static IP? [dhcp/static]: " ip_config_choice
if [[ "$ip_config_choice" == "static" ]]; then
    read -p "Enter static IP address (e.g., 192.168.1.100/24): " ip_address
    read -p "Enter gateway IP address (e.g., 192.168.0.1): " gw_ip
    ip_config="{'net0':'name=eth0,gw=$gw_ip,ip=$ip_address,bridge=vmbr0'}"
else
    ip_config="{'net0':'name=eth0,ip=dhcp,ip6=dhcp,bridge=vmbr0'}"
fi

# Create a YAML file with all the variables to pass to the Ansible playbook
cat <<EOF >/tmp/lxc_provisioning_vars.yml
vCPU: $vCPU
RAM: $RAM
lxc_storage_amount: $lxc_storage_amount
lxc_storage_name: "$lxc_storage_name"
lxc_root_password: "$lxc_root_password"
ct_storage: "$ct_storage"
network_name: "$network_name"
appdata_location: "$appdata_location"
selected_service: "$SELECTED_SERVICE"
selected_service_path: "$SELECTED_SERVICE_PATH"
repo_path: "$DIRECTORY_LOCATION/Wolflith"
hostname: "$hostname"
netif: "$ip_config"
api_host: "$api_host"
api_password: "$api_password"
api_user: "${api_user}@pam"
node: "$node"
EOF

# Remove temporary files
rm /tmp/selected_docker_service.txt
rm /tmp/selected_docker_service_path.txt

echo "Provisioning variables saved to /tmp/lxc_provisioning_vars.yml."

# Now, you would call the Ansible playbook, passing it this YAML file for provisioning
#echo "Ready to provision the LXC container. Run the Ansible playbook with:"
#echo "ansible-playbook -i inventory provision_proxmox.yml -e "@/tmp/lxc_provisioning_vars.yml""
