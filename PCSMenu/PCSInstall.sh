#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

# Create folder
ifolder="/opt/wolflith"

# Update and install necessary packages
apt update && apt install -y sudo curl git make nodejs

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

# Clone wolflith
echo "Cloning wolflith..."
if git clone https://github.com/NorkzYT/wolflith.git $ifolder; then
    echo "Successfully cloned wolflith."
else
    echo "Failed to clone wolflith. Please check the git clone command's output for details."
    exit 1
fi

find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;

# Create aliases in a new script within /etc/profile.d/
echo "alias pcsmenu='sudo /opt/wolflith/PCSMenu/PCSMenu.sh'" | sudo tee /etc/profile.d/PCSMenu.sh >/dev/null
echo "alias pcsupdate='sudo /opt/wolflith/PCSMenu/PCSUpdate.sh'" | sudo tee /etc/profile.d/PCSUpdate.sh >/dev/null

# Make sure the new alias scripts are executable
sudo chmod +x /etc/profile.d/PCSMenu.sh /etc/profile.d/PCSUpdate.sh

# Source PCSFunc if available
[[ -f /opt/wolflith/PCSMenu/PCSFunc.sh ]] && source /opt/wolflith/PCSMenu/PCSFunc.sh
[[ -f /opt/wolflith/PCSMenu/PersonalizationFunc.sh ]] && source /opt/wolflith/PCSMenu/PersonalizationFunc.sh
[[ -f /opt/wolflith/PCSMenu/PCSFunc.sh ]] && default_menu_screen

# Go to directory
cd $ifolder

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
