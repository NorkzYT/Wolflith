#!/bin/bash

# Get the directory of the current script
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"

# Run the modify_docker_env.py script
python3 "$script_dir/modify_docker_env.py" "$1"

# Run the modify_docker_compose.sh script
"$script_dir/modify_docker_compose.sh" "$1"