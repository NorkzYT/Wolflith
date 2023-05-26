#!/bin/bash

# Prompt user for the directory location of the Launchpad GitHub repository
read -p "Enter the directory location of the Launchpad repository: " directory_location

# Validate the directory location
if [ ! -d "$directory_location" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

# Extract IP addresses from the [master] section of the hosts file
ips=$(grep -A1 "\[master\]" $directory_location/Launchpad/Ansible/k3s/inventory/sample/hosts.ini | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | tr '\n' ' ')

# Display the IP addresses as options for the user to choose from
PS3='Which IP do you want to use? '
select ip in $ips; do
    if [ -n "$ip" ]; then
        # Run the scp command with the selected IP
        scp ansibleuser@$ip:~/.kube/config ~/.kube/config
        break
    else
        echo "Invalid selection"
    fi
done
