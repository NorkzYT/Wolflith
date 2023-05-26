#!/bin/bash

# PCSMenu KubernetesFunctions.sh

#####################################################################################################################################################################

### Kubernetes Functions ###

#####################################################################################################################################################################

function kubernetes_banner {
    # Display a banner with the text "Kubernetes"
    printf "$Blue"
    cat <<"EOF"
  _  __     _                          _            
 | |/ /   _| |__   ___ _ __ _ __   ___| |_ ___  ___ 
 | ' / | | | '_ \ / _ \ '__| '_ \ / _ \ __/ _ \/ __|
 | . \ |_| | |_) |  __/ |  | | | |  __/ ||  __/\__ \
 |_|\_\__,_|_.__/ \___|_|  |_| |_|\___|\__\___||___/
                    
                                                    
EOF

    printf "$Color_Off"
    printf "\n"
}

function kubernetes_options() {

    printf "$Cyan"
    printf "1) A. Provision a new cluster     2) B. Get nodes"
    printf "\n"
    printf "3) C. Test Cluster                4) D. Remove k3s from all nodes"
    printf "$Color_Off"
    echo ""

}

# --------------------------------------------------------------- #

####################################################

### 1 ###

####################################################

function kube() {

    printf "The pveperf command is a command-line tool for monitoring and analyzing the performance of a Proxmox VE cluster. It displays various performance metrics, such as CPU usage, memory usage, and network usage, for all nodes in the cluster.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        kube
    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        kubernetes

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            kubernetes_banner
            kube
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            kubernetes_banner
            kube
        fi
    fi

}

#####################################################################################################################################################################
