#!/bin/bash

# This script does the following:

#Finds all .env files in the current directory and its subdirectories.
#Reads the contents of each .env file into an array, filtering out comments and empty lines.
#Loops through the array of environment variables and splits each one into a name and value field using the "=" character as a delimiter.
#Assigns the name field of each environment variable to the variable "name".
#Outputs the value of "name" to a file called env_var_names.txt.
#Prints a message indicating that the script has finished running.

echo "Starting to process .env files..."

# Initialize the output file to ensure it's empty at the start.
>Temp/env_var_names.txt

# Find all .env files
find . -type f -name "*.env" | while read -r env_file; do
    echo "Processing file: $env_file"

    # Read .env file into an array, filtering out comments and empty lines
    mapfile -t env_vars < <(grep -vE '^#|^$' "$env_file")

    # Check if env_vars is empty
    if [ ${#env_vars[@]} -eq 0 ]; then
        echo "No valid environment variables found in $env_file"
    else
        # Loop through array of environment variables
        for env_var in "${env_vars[@]}"; do
            # Extract the name of the environment variable
            name="${env_var%%=*}"

            # Output variable name to file
            echo "$name" >>Temp/env_var_names.txt
        done
    fi
done

echo "Finished outputting environment variable names to Temp/env_var_names.txt."
