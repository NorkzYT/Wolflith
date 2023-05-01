#!/bin/bash

# Install Ansible if not already installed
if ! command -v ansible &> /dev/null; then
    echo "Ansible is not installed. Installing Ansible..."
    sudo apt-get update
    sudo apt-get install -y ansible
fi

# Prompt user for the directory location of the Launchpad GitHub repository
read -p "Enter the directory location of the Launchpad repository: " directory_location

# Validate the directory location
if [ ! -d "$directory_location" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

# Save the directory location
echo "$directory_location" >$directory_location/Scripts/directory_location.txt

# Get the saved directory location, if any
saved_location=$(cat $directory_location/Scripts/directory_location.txt 2>/dev/null)

# Save the directory location
echo "$directory_location" >$directory_location/Scripts/directory_location.txt

# Update the Makefile with the new directory location
sed -i "s#/home/user#$directory_location#" Makefile

echo "Makefile updated with the new directory location."