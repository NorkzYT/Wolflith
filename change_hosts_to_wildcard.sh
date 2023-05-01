#!/bin/bash

# Prompt user for the directory location of the Launchpad GitHub repository
read -p "Enter the directory location of the Launchpad repository: " directory_location

# Validate the directory location
if [ ! -d "$directory_location" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

playbook_dir="$directory_location/Launchpad/Ansible/playbooks"

# Restore the original playbook files
find "$playbook_dir" -type f -name "*.yml.backup" -exec sh -c 'mv "$1" "${1%.backup}"' _ {} \;

# Remove the backup files
find "$playbook_dir" -type f -name "*.yml.backup" -exec rm {} \;

echo "The playbook hosts have been changed back to wildcard."
