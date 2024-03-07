#!/bin/bash

# This script captures inputs, it should append them to /opt/Wolflith/Temp/lxc_provisioning_vars.yml in a format
# compatible with the provisioning playbook.

# User inputs are captured and stored in variables:
# folder_name, cifs_host, share_name, smb_username, smb_password, lxc_id, lxc_username

# Ask user for necessary inputs
read -rp "Enter the folder name (e.g., nas_rwx): " folder_name
read -rp "Enter the CIFS hostname or IP (e.g., NAS): " cifs_host
read -rp "Enter the SMB share name (e.g., media): " share_name
read -rp "Enter SMB username: " smb_username
read -rsp "Enter SMB password: " smb_password && echo
read -rp "Enter the username within the LXC that needs access to the share (e.g., jellyfin, plex): " lxc_username

# Append captured CIFS share details to lxc_provisioning_vars.yml
cat <<EOF >>/opt/Wolflith/Temp/lxc_provisioning_vars.yml
cifs_share_details:
  folder_name: "$folder_name"
  cifs_host: "$cifs_host"
  share_name: "$share_name"
  smb_username: "$smb_username"
  smb_password: "$smb_password"
  lxc_username: "$lxc_username"
EOF
