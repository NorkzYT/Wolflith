#!/bin/bash

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

# Run the modify_docker_env.py script
python3 ./modify_docker_env.py
