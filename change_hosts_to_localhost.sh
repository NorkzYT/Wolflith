#!/bin/bash

# Prompt user for the directory location of the Launchpad GitHub repository
read -p "Enter the directory location of the Launchpad repository: " directory_location

# Validate the directory location
if [ ! -d "$directory_location" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

# Save the directory location
echo "$directory_location" >$directory_location/Launchpad/Scripts/directory_location.txt

playbook_dir="$directory_location/Launchpad/Ansible/playbooks"

# Backup the original files
find "$playbook_dir" -type f -name "*.yml" -exec cp {} {}.backup \;

# Replace '- hosts: *' with '- hosts: localhost' in all the playbook files
find "$playbook_dir" -type f -name "*.yml" -exec sed -i 's/- hosts: \*/- hosts: localhost/g' {} \;

echo "The playbook hosts have been changed to localhost."
