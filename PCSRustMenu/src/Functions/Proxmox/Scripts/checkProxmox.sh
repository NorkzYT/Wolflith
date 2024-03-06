#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

if ! pveversion &>/dev/null; then
    echo "This script needs to be run on a Proxmox VE system."
    exit 1
fi
