#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

if ! [[ "$(uname -s)" == "Linux" ]]; then
    echo "This script needs to be run on a Linux system."
    exit 1
fi
