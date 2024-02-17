#!/bin/bash

# Source the color functions
source PCSMenu/Functions/PersonalizationFunctions.sh


# Define the base directory to search within
base_dir="/opt/wolflith/Docker"

# Check if base directory exists
if [ ! -d "$base_dir" ]; then
    redprint "Error: The base directory $base_dir does not exist."
    exit 1
fi

cyanprint "Scanning for .env.example files to set up environment..."

# List of subdirectories to check
subdirs=("AMD64" "ARM64" "Both")

# Iterate over each specified subdirectory
for subdir in "${subdirs[@]}"; do
    # Full path to the current subdirectory
    full_path="$base_dir/$subdir"

    # Check if the subdirectory exists
    if [ -d "$full_path" ]; then
        # Use find to recursively search for .env.example files in the subdirectory
        find "$full_path" -type f -name ".env.example" | while read -r env_example_file; do
            # Determine the path for the .env file
            env_file="${env_example_file%.example}"

            # Check if the .env file does not exist
            if [ ! -f "$env_file" ]; then
                greenprint "Creating: $env_file"
                cp "$env_example_file" "$env_file"
            else
                yellowprint "Notice: .env file already exists for $env_file, skipping."
            fi
        done
    else
        magentaprint "Info: Subdirectory $subdir does not exist under $base_dir"
    fi
done

greenprint "Environment setup complete."
