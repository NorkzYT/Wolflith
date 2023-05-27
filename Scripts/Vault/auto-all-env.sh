#!/bin/bash

# This script does the following:

#Finds all .env files in the current directory and its subdirectories.
#Reads the contents of each .env file into an array, filtering out comments and empty lines.
#Loops through the array of environment variables and splits each one into a name and value field using the "=" character as a delimiter.
#Assigns the name field of each environment variable to the variable "name".
#Outputs the value of "name" to a file called env_var_names.txt.
#Prints a message indicating that the script has finished running.

#Find all .env files
for env_file in $(find . -name "*.env"); do

    # Read .env file into an array, filtering out comments and empty lines
    mapfile -t env_vars < <(grep -v '^#\|^$' "$env_file")

    # Loop through array of environment variables
    for env_var in "${env_vars[@]}"; do
        # Split input string into array
        IFS="=" read -ra parts <<<"$env_var"

        # Assign values to variables
        name=$(echo "$env_var" | cut -d '=' -f 1)

        # Output variable name to file
        echo "$name" >>env_var_names.txt
    done
done

# Print message indicating that the script has finished running
echo "Finished outputting environment variable names to env_var_names.txt"
