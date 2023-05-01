#!/bin/bash

# Prompt user for the directory location of the Launchpad GitHub repository
read -p "Enter the directory location of the Launchpad repository: " directory_location

# Validate the directory location
if [ ! -d "$directory_location" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

playbook_dir="$directory_location/Launchpad/Ansible/playbooks"

# Replace 'hosts: localhost' with 'hosts: all' in all the playbook files
find "$playbook_dir" -type f -name "*.yml" -exec sed -i 's/hosts: localhost/hosts: all/g' {} \;

# Remove the 'connection: local' line after 'hosts: all' in all the playbook files
find "$playbook_dir" -type f -name "*.yml" -exec sed -i '/hosts: all/{n;d;}' {} \;

echo "The playbook hosts have been changed back to wildcard."
