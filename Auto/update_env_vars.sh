#!/bin/bash

# Ask for Launchpad repository location
echo "Enter Launchpad repository location:"
read repo_path

# Check if the location exists
if [ ! -d "$repo_path" ]; then
    echo "Directory $repo_path does not exist."
    exit 1
fi

# Check if yq is installed, if not then install it
if ! command -v yq &> /dev/null; then
    echo "yq could not be found. Installing yq."
    wget https://github.com/mikefarah/yq/releases/download/v4.34.1/yq_linux_amd64.tar.gz -O - |\
    tar xz && sudo mv yq_linux_amd64 /usr/bin/yq
fi

# Find docker-compose.yml files in the 'Docker/Both/' location inside of the repo
compose_files=$(find "$repo_path" -path '*/Docker/Both/*' -name 'docker-compose.yml')

# Loop over found files
for file in $compose_files; do
    # Get service names
    service_names=$(yq e '.services.*.hostname' "$file")
    
    # Loop over each service
    for service in $service_names; do
        # If service has environment variables
        if yq e ".services.$service.environment" "$file" > /dev/null; then
            # Extract environment variables
            env_vars=$(yq e ".services.$service.environment" "$file")
            env_file="$repo_path/.env.$service"

            # Write each environment variable to a .env file
            echo "$env_vars" | while read -r line; do
                var=$(echo "$line" | cut -d '=' -f1)
                val=$(echo "$line" | cut -d '=' -f2-)
                
                # Write environment variable to .env file
                echo "${service^^}_$var=$val" >> "$env_file"

                # Replace environment variable in docker-compose.yml file
                yq e -i ".services.$service.environment[] = \"$var=\${${service^^}_$var}\"" "$file"
            done
        fi
    done
done

echo "Environment variables have been extracted to .env files and replaced in docker-compose.yml files."
