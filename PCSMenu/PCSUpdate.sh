#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSMenu/src/Color.sh

# Go to specific directory
cd "/opt/Wolflith" || exit

# Fetch the latest changes
git fetch origin

# Pull the latest changes
git pull origin

# Fetch the latest version tag from GitHub API
LATEST_VERSION=$(curl -s https://api.github.com/repos/NorkzYT/Wolflith/releases/latest | jq -r .tag_name)

# Check if jq or curl failed (empty LATEST_VERSION)
if [ -z "$LATEST_VERSION" ]; then
    redprint "Failed to fetch the latest version. Update canceled."
    exit 1
fi

# Update the version in the version file
echo "$LATEST_VERSION" >/opt/Wolflith/PCSMenu/version

cyanprint "PCSMenu has been updated to the latest version: $LATEST_VERSION."
