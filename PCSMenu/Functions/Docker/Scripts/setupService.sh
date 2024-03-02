#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSMenu/PCSFunc.sh
source /opt/Wolflith/PCSMenu/PersonalizationFunc.sh

cyanprint "Have you configured the .env before trying to setup the service? [y/N]: "
read -rp "" run_command

if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
    # Continue with the setup as the .env file is configured
    :
elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
    # Operation canceled by the user, return to the main menu
    magentaprint "Operation canceled. Returning to the main menu..."
    proxmox_menu
    return
else
    # The user entered an invalid answer
    invalid_answer
    clear
    menu_cover
    run_command
fi
