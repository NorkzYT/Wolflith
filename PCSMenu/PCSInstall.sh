#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

# Create folder
ifolder="/opt/Wolflith"

# Update and install necessary packages
apt update && apt install -y sudo curl git make nodejs npm

# Install bun globally
npm install -g bun

# Check if git is installed
if ! command -v git &>/dev/null; then
    echo "git could not be found, installing..."
    apt install git -y
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
echo "alias pcsmenu='sudo /opt/Wolflith/PCSMenu/PCSMenu.sh'" | sudo tee $alias_file >/dev/null
echo "alias pcsupdate='sudo /opt/Wolflith/PCSMenu/PCSUpdate.sh'" | sudo tee -a $alias_file >/dev/null

# If using zsh, append aliases to .zshrc for users that login with zsh
if command -v zsh &>/dev/null; then
    echo "alias pcsmenu='sudo /opt/Wolflith/PCSMenu/PCSMenu.sh'" | sudo tee -a /etc/zsh/zshrc >/dev/null
    echo "alias pcsupdate='sudo /opt/Wolflith/PCSMenu/PCSUpdate.sh'" | sudo tee -a /etc/zsh/zshrc >/dev/null
fi

# Make sure the new alias script is executable
sudo chmod +x $alias_file

# Source PCSFunc if available
[[ -f /opt/Wolflith/PCSMenu/PCSFunc.sh ]] && source /opt/Wolflith/PCSMenu/PCSFunc.sh
[[ -f /opt/Wolflith/PCSMenu/PCSFunc.sh ]] && default_menu_screen

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
cyanprint "Type 'pcsupdate' to update"

# Cleanup the initial PCSInstall
rm -f /opt/PCSInstall.sh
