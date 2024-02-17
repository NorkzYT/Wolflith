#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/wolflith/PCSMenu/PersonalizationFunc.sh

# Default values
default_vCPU=2
default_RAM=2048  # in MB
default_Storage=6 # in GB
default_storage_name="local"
default_ct_storage="local"
default_api_user="root"
default_node="pve"

SELECTED_SERVICE=$(cat /tmp/selected_docker_service.txt)
HOSTS_FILE="/opt/wolflith/Ansible/inventory/hosts.yaml"
TARGET_HOST="$ANSIBLE_PLAYBOOK_TARGET"

# Extract ansible_host (WAN IP), ansible_user (API user), and ansible_ssh_pass (API password)
read api_host api_user api_password <<<$(awk -v target="$TARGET_HOST" '
BEGIN {
    RS=""; FS="\n"
    host_found = 0; user = ""; pass = ""
}
$0 ~ "hosts:" {
    split($0, lines, FS)
    for (i in lines) {
        line = lines[i]
        if (line ~ target ":") {
            host_found = 1
        }
        if (host_found) {
            if (line ~ /ansible_host:/) {
                gsub("ansible_host: ", "", line)
                host = line
            }
            if (line ~ /ansible_user:/) {
                gsub("ansible_user: ", "", line)
                user = line
            }
            if (line ~ /ansible_ssh_pass:/) {
                gsub("ansible_ssh_pass: ", "", line)
                pass = line
                break
            }
        }
    }
}
END {
    if (user == "" || pass == "") { # If not found in host specifics, use group vars
        print host, "root", "xxx" # Fallback or adjust to retrieve from group vars if necessary
    } else {
        print host, user, pass
    }
}' "$HOSTS_FILE")

# Use color functions to print headers and information
blueprint "Configuration for Proxmox LXC Provisioning"

# If api_host is empty, fallback to user input
if [ -z "$api_host" ]; then
    greenprint "Enter Proxmox VE API host (e.g., 24.156.99.202 [WAN IP]): "
    read api_host
else
    greenprint "Proxmox VE API host (WAN IP) extracted: $api_host"
fi

# Prompt for API User if not extracted
if [ -z "$api_user" ]; then
    greenprint "Enter Proxmox VE API user (default: $default_api_user): "
    read api_user
    api_user=${api_user:-$default_api_user}
    echo ""
else
    greenprint "Proxmox VE API user extracted: $api_user"
fi

# Prompt for API password if not extracted
if [ -z "$api_password" ]; then
    greenprint "Enter Proxmox VE API password: "
    read -sp "" api_password
    echo ""
else
    greenprint "Proxmox VE API password extracted"
fi

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

# Generate and display root password for LXC
lxc_root_password=$(openssl rand -base64 24)
greenprint "Generated root password for LXC: $lxc_root_password"

# Save the LXC root password with the hostname into an organized file
PASSWORDS_FILE="$SCRIPT_DIR/../../../Temp/lxc_passwords.txt"
echo "Hostname: $hostname - Root Password: $lxc_root_password" >>"$PASSWORDS_FILE"
greenprint "LXC root password for $hostname saved to $PASSWORDS_FILE"

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
