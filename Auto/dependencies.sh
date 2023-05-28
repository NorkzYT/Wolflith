#!/bin/bash

# Install Ansible if not already installed
if ! command -v ansible &>/dev/null; then
    echo "Ansible is not installed. Installing Ansible..."
    sudo apt-get update
    sudo apt-get install -y ansible
else
    echo "Ansible is already installed."
fi

# Function to fetch the latest Go archive URL for the specified architecture
get_latest_url() {
    local architecture="$1"
    local url="https://go.dev/dl/"

    # Use Python to scrape the webpage and extract the latest URL for the specified architecture
    local latest_url=$(
        python3 - <<END
import requests
from bs4 import BeautifulSoup

architecture = "$architecture"
url = "$url"

# Fetch the webpage content
response = requests.get(url)
soup = BeautifulSoup(response.content, "html.parser")

# Find the download links based on the architecture
links = [a["href"] for a in soup.find_all("a", href=True) if a["href"].startswith("/dl/go") and architecture in a["href"] and 'linux' in a["href"] and a["href"].endswith('tar.gz')]
if links:
    # Extract the latest URL for the specified architecture
    latest_url = "https://go.dev" + links[0]
    print(latest_url)
END
    )

    echo "$latest_url"
}

valid_archs=("armv6l" "arm64" "amd64")
while true; do
    echo ""
    echo "Input the Go arch to install (Options: armv6l/arm64/amd64) or 'x' to exit."
    read -p "Architecture: " arch
    echo ""
    if [[ " ${valid_archs[@]} " =~ " ${arch} " ]]; then
        break
    elif [ "$arch" == "x" ]; then
        exit 0
    else
        echo "Invalid input. Please try again."
        sleep 1
        clear
    fi
done

# Get the latest URL for the specified architecture
latest_url=$(get_latest_url "$arch")

if [ -z "$latest_url" ]; then
    echo "Failed to retrieve the latest Go archive URL for the specified architecture"
    exit 1
fi

file_name=$(basename "$latest_url")

if [ -f "$file_name" ]; then
    echo "Go archive file already exists. Skipping download."
else
    echo "Downloading Go archive..."
    wget "$latest_url"
fi

if [ -f "$file_name" ]; then
    sudo rm -rf /usr/local/go
    sudo tar -C /usr/local -xzf "$file_name"
    echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.profile
    source ~/.profile
    echo "Go installation completed."
    echo "Verify that you've installed Go by opening a new terminal and typing the following command:"
    echo -e "\033[32mgo version\033[0m"
    echo "Confirm that the command prints the installed version of Go."
else
    echo "Failed to find the Go archive file: $file_name"
fi

# Check if Python is installed
if ! command -v python3 &>/dev/null; then
    echo ""
    echo "Python is not installed. Installing..."
    sudo apt update
    sudo apt install -y python3
else
    echo ""
    echo "Python is already installed."
fi

# Function to check if BeautifulSoup is installed
is_beautifulsoup_installed() {
    python3 - <<END
import pkgutil

if pkgutil.find_loader("bs4"):
    print("True")
else:
    print("False")
END
}

# Install BeautifulSoup if it is not already installed
if ! pip freeze | grep -q beautifulsoup4; then
    echo "BeautifulSoup is not installed. Installing it..."
    echo ""
    pip install beautifulsoup4
else
    echo "BeautifulSoup is already installed."
fi

# Check if PyYAML is installed
if ! python3 -c "import yaml" &>/dev/null; then
    echo "PyYAML is not installed. Installing..."
    pip3 install PyYAML
else
    echo "PyYAML is already installed."
fi

# Check if ruamel.yaml is installed
if ! python3 -c "import ruamel.yaml" &>/dev/null; then
    echo "ruamel.yaml is not installed. Installing..."
    pip3 install ruamel.yaml
else
    echo "ruamel.yaml is already installed."
fi
