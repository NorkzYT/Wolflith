#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

# Create folder
ifolder="/opt/wolflith"
mkdir -p $ifolder

# Update and install necessary packages
apt update && apt install -y sudo curl git make nodejs

# Install global npm packages
npm install -g bun opencommit

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
if git clone -b main --single-branch https://github.com/NorkzYT/wolflith.git $ifolder; then
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
[[ -f /opt/wolflith/PCSMenu/PCSFunc.sh ]] && menu_cover

if [[ -n $1 ]]; then
    cyanprint "Type 'pcsmenu' to launch PCSMENU"
    cyanprint "Type 'pcsupdate' to update"
fi

# Go to directory
cd $ifolder

# Run Setup
if make setup; then
    echo "Setup completed successfully."
else
    echo "Setup failed. Please check the output for details."
    exit 1
fi

# Cleanup the initial PCSInstall
rm -f /opt/wolflith/PCSInstall.sh
