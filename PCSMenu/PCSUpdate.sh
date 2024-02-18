#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/wolflith/PCSMenu/PersonalizationFunc.sh

# Go to specific directory
cd "/opt/wolflith"

# Fetch the latest changes from the main branch
git fetch origin main

# Hard reset to the latest commit on the main branch
git reset --hard origin/main

# Pull the latest changes
git pull origin main

cyanprint "PCSMenu has been updated to the latest version."
