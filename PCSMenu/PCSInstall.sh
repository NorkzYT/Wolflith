#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

# Create folder
ifolder="/opt/Wolflith"

# Update and install necessary packages
apt update && apt install -y sudo curl git make

# Install nodejs which includes npm in recent versions
apt install -y nodejs

# Check if npm is installed, if not install it
if ! command -v npm &>/dev/null; then
    echo "npm could not be found, installing..."
    apt install npm -y
else
    echo "npm is already installed, skipping installation."
fi

# Check if bun is installed, if not install it
if ! command -v bun &>/dev/null; then
    echo "bun could not be found, installing..."
    npm install -g bun
else
    echo "bun is already installed, skipping installation."
fi

# Check if git is installed
if ! command -v git &>/dev/null; then
    echo "git could not be found, installing..."
    apt install git -y
else
    echo "git is already installed, skipping installation."
fi

# Check network connectivity to GitHub
if ! ping -c 1 github.com &>/dev/null; then
    echo "Unable to reach GitHub, please check your network connection."
    exit 1
fi

# Parse branch argument correctly
branch="main" # Default branch
if [[ "$1" == "--branch="* ]]; then
    branch="${1#*=}" # Extract branch name after "="
fi

# Make Wolflith folder
if [ ! -d "/opt/Wolflith" ]; then
    mkdir -p /opt/Wolflith
fi

echo "Cloning Wolflith from branch $branch..."
if git clone --branch "$branch" https://github.com/NorkzYT/Wolflith.git $ifolder; then
    echo "Successfully cloned Wolflith from branch $branch."
else
    echo "Failed to clone Wolflith. Please check the git clone command's output for details."
    exit 1
fi

find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;

# Create aliases for both bash and zsh shells
alias_file="/etc/profile.d/PCSMenu_aliases.sh"
alias_command="alias pcsmenu='sudo /opt/Wolflith/PCSMenu/target/release/pcsmenu'"
if grep -q "alias pcsmenu=" "$alias_file"; then
    sudo sed -i "/alias pcsmenu=/c\\$alias_command" "$alias_file"
else
    echo "$alias_command" | sudo tee -a $alias_file >/dev/null
fi

# Check if zsh is installed and echo a message for debugging
if command -v zsh &>/dev/null; then
    echo "Zsh is installed, proceeding with updates to .zshrc files."
    for zshrc in /home/*/.zshrc; do
        if [ -f "$zshrc" ]; then
            if grep -q "alias pcsmenu=" "$zshrc"; then
                sed -i "/alias pcsmenu=/c\\$alias_command" "$zshrc"
            else
                echo "$alias_command" >>"$zshrc"
                echo "Please run 'source ~/.zshrc' or start a new shell session to use the new aliases."
            fi
        else
            echo "$zshrc does not exist."
        fi
    done
else
    echo "Zsh is not installed, no need to update .zshrc files."
fi

# Make sure the new alias script is executable
sudo chmod +x $alias_file
source $alias_file

# Source PCSFunc if available
[[ -f /opt/Wolflith/PCSMenu/src/PCSFunc.sh ]] && source /opt/Wolflith/PCSMenu/src/PCSFunc.sh
[[ -f /opt/Wolflith/PCSMenu/src/PCSFunc.sh ]] && default_menu_screen

# Go to directory
cd $ifolder || exit

# Run Setup
if make setup; then
    echo "Setup completed successfully."
else
    echo "Setup failed. Please check the output for details."
    exit 1
fi

echo "Press 'c' to continue..."
while read -r -n 1 key; do
    if [[ $key == c ]]; then
        echo "Key 'c' pressed. Continuing..."
        break
    else
        echo "Press 'c' to continue..."
    fi
done

default_menu_screen
cyanprint "Type 'pcsmenu' to launch PCSMENU"

# Cleanup the initial PCSInstall
rm -f /opt/PCSInstall.sh
