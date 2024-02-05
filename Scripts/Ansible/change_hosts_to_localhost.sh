#!/bin/bash

# Prompt user for the directory location of the Wolflith GitHub repository
read -p "Enter the directory location of the Wolflith repository: " directory_location

# Validate the directory location
if [ ! -d "$directory_location" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

# Save the directory location
echo "$directory_location" > "$directory_location/Wolflith/Scripts/directory_location.txt"

playbook_dir="$directory_location/Wolflith/Ansible/playbooks"

# Replace 'hosts: all' with 'hosts: localhost' in all the playbook files
find "$playbook_dir" -type f -name "*.yml" -exec sed -i 's/hosts: all/hosts: localhost/g' {} \;

# Add 'connection: local' after 'hosts: localhost' in all the playbook files
find "$playbook_dir" -type f -name "*.yml" -exec sed -i "/hosts: localhost/a \  connection: local" {} \;

echo "The playbook hosts have been changed to localhost."
