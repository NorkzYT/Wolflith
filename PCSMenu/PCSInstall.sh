#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

# Create folder
ifolder="/opt/wolflith"
mkdir -p $ifolder

# Clone wolflith
apt update
apt install sudo curl git make nodejs -y
npm install -g bun opencommit
git clone -b main --single-branch https://github.com/NorkzYT/wolflith.git $ifolder
find $ifolder -type f -iname "*.sh" -exec chmod +x {} \;

# Create aliases in a new script within /etc/profile.d/
echo "alias pcsmenu='sudo /opt/wolflith/PCSMenu/PCSMenu.sh'" | sudo tee /etc/profile.d/PCSMenu.sh >/dev/null
echo "alias pcsupdate='sudo /opt/wolflith/PCSMenu/PCSUpdate.sh'" | sudo tee /etc/profile.d/PCSUpdate.sh >/dev/null

# Make sure the new alias scripts are executable
sudo chmod +x /etc/profile.d/PCSMenu.sh /etc/profile.d/PCSUpdate.sh

source /opt/wolflith/PCSMenu/PCSFunc.sh
source /opt/wolflith/PCSMenu/PersonalizationFunc.sh
menu_cover
if [[ -n $1 ]]; then

    cyanprint "Type 'pcsmenu' to launch PCSMENU"
    cyanprint "Type 'pcsupdate' to update"

fi

# Go to directory
cd $ifolder

# Run Setup
make setup

# cleanup the initial PCSInstall
rm /opt/wolflith/PCSInstall.sh
