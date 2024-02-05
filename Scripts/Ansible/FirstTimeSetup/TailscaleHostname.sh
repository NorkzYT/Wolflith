#!/bin/bash

directory_location="$1"

# Check if directory_location is empty
if [ -z "$directory_location" ]; then
    read -p "Enter the directory location: " directory_location
fi

# Get the hostname of the machine
hostname=$(hostname)

# Change directory to the Tailscale folder
cd "$directory_location"/Wolflith/Docker/Containers/Tailscale

# Replace the "hostname: VPS" line in docker-compose.yml with the actual hostname
sed -i "s/hostname: VPS/hostname: $hostname/" docker-compose.yml
