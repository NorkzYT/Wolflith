#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSMenu/PersonalizationFunc.sh

# Go to specific directory
cd "/opt/Wolflith" || exit

# Fetch the latest changes
git fetch origin

# Hard reset to the latest commit
git reset --hard origin

# Pull the latest changes
git pull origin

cyanprint "PCSMenu has been updated to the latest version."
