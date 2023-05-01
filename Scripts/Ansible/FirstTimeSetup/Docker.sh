#!/bin/bash

# Ask the user for the directory location
read -p "Enter the parent directory location for where the 'Launchpad' folder is located: " parent_directory

# Use the 'find' command to search for the 'Launchpad' folder in the parent directory
directory_location=$(find $parent_directory -type d -name "Launchpad" | head -n 1)

# Check if the 'Launchpad' folder was found
if [[ -z "$directory_location" ]]; then
    echo "Error: Could not find 'Launchpad' folder in the specified parent directory."
    exit 1
fi

# Save the directory location
echo "$directory_location" >$directory_location/Scripts/directory_location.txt

# Get the saved directory location, if any
saved_location=$(cat $directory_location/Scripts/directory_location.txt 2>/dev/null)

# Save the directory location
echo "$directory_location" >$directory_location/Scripts/directory_location.txt

# ------------------------------------------------------------------------------------------------------------------------ #

# Runs the the following Ansible playbooks in order which is only for every new machine that needs to be setup.

# ------------------------------------------------------------------------------------------------------------------------ #

# This ansible playbook installs Docker and Docker Compose on all hosts specified in the hosts field and tests their installations by running commands.
# It also adds the ubuntu user to the docker group to allow the user to run Docker commands without using sudo.
ansible-playbook "$directory_location/Ansible/playbooks/docker.yml" -i "$directory_location/Ansible/inventory/hosts"

#The playbook creates a Docker network named proxymoxy on all hosts in the inventory using the docker_network module, -
# with sudo privileges and a present state to ensure the network is created if it does not exist.
ansible-playbook "$directory_location/Ansible/playbooks/docker-network.yml" -i "$directory_location/Ansible/inventory/hosts"

# This ansible playbook installs and runs the tonistiigi/binfmt Docker image on all specified hosts to enable support for running non-native executables in containers.
# It consists of three tasks: pulling the image, installing all binary formats, and adding a command to the /etc/rc.d/rc.local file to run the command on boot.
ansible-playbook "$directory_location/Ansible/playbooks/binfmt.yml" -i "$directory_location/Ansible/inventory/hosts"

# This playbook makes the DockerContainerSetup script executable and runs it on all hosts in the inventory with sudo privileges.
ansible-playbook "$directory_location/Ansible/playbooks/first-time-docker-container-setup.yml" \
    -i "$directory_location/Ansible/inventory/hosts" \
    -e "directory_location=$directory_location"

# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------------------ #
