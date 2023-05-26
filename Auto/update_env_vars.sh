#!/bin/bash

# Get the directory of the current script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Check if Python is installed
if ! command -v python3 &>/dev/null; then
    echo "Python is not installed. Installing..."
    sudo apt update
    sudo apt install -y python3
fi

# Check if PyYAML is installed
if ! python3 -c "import yaml" &>/dev/null; then
    echo "PyYAML is not installed. Installing..."
    pip3 install PyYAML
fi

# Check if ruamel.yaml is installed
if ! python3 -c "import ruamel.yaml" &>/dev/null; then
    echo "ruamel.yaml is not installed. Installing..."
    pip3 install ruamel.yaml
fi

echo ""
echo "This next script automates the process of managing environment variables in your Launchpad repository."
echo "Here's what it does:"
echo "1. Accepts the location of your Launchpad repository as input."
echo "2. Checks if the repository location exists and appends '/Launchpad' if needed."
echo "3. Searches for 'docker-compose.yml' files within the 'Docker' directory of your repository."
echo "4. Examines the environment variables defined in each service of the 'docker-compose.yml' files."
echo "5. Modifies the environment variables to ensure they follow the 'KEY=VALUE' format."
echo "6. Updates the corresponding '.env.example' file with the modified environment variables."
echo "7. Saves the changes back to the 'docker-compose.yml' files."
echo "8. If any errors are encountered during the process, they are recorded in 'error_messages.txt'."
echo "9. Notifies you when the process is completed."
echo ""

# Run the modify_docker_env.py script
python3 "$script_dir/modify_docker_env.py" "$1"
