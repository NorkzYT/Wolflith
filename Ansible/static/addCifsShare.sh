#!/bin/bash

# Script parameters
folder_name="$1"
cifs_host="$2"
share_name="$3"
smb_username="$4"
smb_password="$5"
cred_file="/etc/cifs-${folder_name}.cred"

# Create CIFS credentials file
echo "username=${smb_username}" >"${cred_file}"
echo "password=${smb_password}" >>"${cred_file}"
chmod 0600 "${cred_file}"

# Form the fstab entry line
fstab_entry="//${cifs_host}/${share_name} /mnt/lxc_shares/${folder_name} cifs _netdev,x-systemd.automount,noatime,nobrl,uid=100000,gid=110000,dir_mode=0770,file_mode=0770,credentials=${cred_file} 0 0"

# Check if the fstab entry exists
if ! grep -q "//${cifs_host}/${share_name} /mnt/lxc_shares/${folder_name}" /etc/fstab; then
    echo "Adding NAS CIFS share to /etc/fstab..."
    echo "$fstab_entry" >>/etc/fstab
else
    echo "Entry for ${cifs_host}/${share_name} on /mnt/lxc_shares/${folder_name} already exists in /etc/fstab."
fi

# Reload systemd to recognize changes to fstab
systemctl daemon-reload

# Ensure the mount point is not already in use and mount
if mountpoint -q "/mnt/lxc_shares/$folder_name"; then
    umount -l "/mnt/lxc_shares/$folder_name"
fi
mount "/mnt/lxc_shares/$folder_name"
