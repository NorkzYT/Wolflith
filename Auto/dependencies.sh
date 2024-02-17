#!/bin/bash

# Source the PersonalizationFunctions for color support
source /opt/wolflith/PCSMenu/PersonalizationFunc.sh

# Function to install Ansible
install_ansible() {
    if ! command -v ansible &>/dev/null; then
        echo "Ansible is not installed. Installing Ansible..."
        python3 -m pip install --user ansible
        if [ $? -ne 0 ]; then
            echo "Failed to install Ansible. Please check your package manager settings."
            exit 1
        fi
    else
        echo "Ansible is already installed."
    fi
}

# Function to install required Ansible collections
install_ansible_required_collections() {
    local script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
    if ansible-galaxy collection install -r "/opt/wolflith/Ansible/collections/requirements.yml"; then
        greenprint "Required collections installed successfully."
    else
        redprint "Failed to install required collections."
        exit 1
    fi
}

# Function to install Python3
install_python() {
    if ! command -v python3 &>/dev/null; then
        echo "Python is not installed. Installing..."
        sudo apt update && sudo apt install -y python3
        if [ $? -ne 0 ]; then
            echo "Failed to install Python. Please check your package manager settings."
            exit 1
        fi
    else
        echo "Python is already installed."
    fi
}

# Function to install Python dependencies from requirements.txt
install_python_dependencies() {
    echo "Installing Python dependencies..."
    pip3 install -r Auto/requirements.txt
    if [ $? -ne 0 ]; then
        echo "Failed to install Python dependencies. Please check your Python environment."
        exit 1
    fi

    echo "Python dependencies installed successfully."
}

# Function to install Go with user-specified architecture
install_go() {
    if command -v go &>/dev/null; then
        echo "Go is already installed."
        return
    fi

    echo "Go is not installed. Proceeding with the installation."
    # Define valid architectures
    valid_archs=("armv6l" "arm64" "amd64")
    echo "Select the Go architecture to install: "
    select arch in "${valid_archs[@]}"; do
        case $arch in
        armv6l | arm64 | amd64)
            break
            ;;
        *)
            echo "Invalid selection. Please try again."
            ;;
        esac
    done

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

        # Determine the shell and append the PATH update to the appropriate configuration file
        if [ "$SHELL" = "/bin/zsh" ]; then
            echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.zshrc
            echo "Please run 'source ~/.zshrc' or restart your terminal to apply changes."
        else
            echo 'export PATH=$PATH:/usr/local/go/bin' >>~/.profile
            echo "Please run 'source ~/.profile' or restart your terminal to apply changes."
        fi

        echo "Go installation completed."
        echo "Verify the installation by executing 'go version' after applying the changes."
    else
        echo "Failed to find the Go archive file: $file_name"
        exit 1
    fi
}

# Main execution flow
install_python
install_python_dependencies
install_ansible
install_ansible_required_collections
export ANSIBLE_CONFIG=/opt/wolflith/Ansible/inventory/ansible.cfg
install_go
