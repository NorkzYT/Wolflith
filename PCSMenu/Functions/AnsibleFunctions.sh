#!/bin/bash

source Functions/MainFunctions.sh

# PCSMenu AnsibleFunctions.sh

#####################################################################################################################################################################

### Ansible Functions ###

#####################################################################################################################################################################

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DIRECTORY_LOCATION=$(cat "$SCRIPT_DIR/../../Scripts/directory_location.txt")

function ansible_banner() {
    printf "$White"
    # Display a banner with the text "Ansible"
    cat <<"EOF"

     _              _ _     _      
    / \   _ __  ___(_) |__ | | ___ 
   / _ \ | '_ \/ __| | '_ \| |/ _ \
  / ___ \| | | \__ \ | |_) | |  __/
 /_/   \_\_| |_|___/_|_.__/|_|\___|
                                   

EOF
    printf "$Color_Off"
    printf "\n"
}

##### Ansible Menu Options #####
function ansible_options() {

    printf "$Cyan"
    printf "1) Setup Hosts/Add More Machines                            2) Setup New Machines"
    printf "\n"
    printf "3) C. Setup Kubernetes Cluster                              4) D. Accessing Kubernetes Cluster"
    printf "\n"
    printf "5) E. Testing Kubernetes Cluster"
    printf "$Color_Off"
    echo ""

}

#### Functions SECTION ####

# --------------------------------------------------------------- #

function ansible_message() {
    printf "\nConfigure "Ansible/inventory/hosts.yaml" with the first option before choosing any other option!\n\n"

}

####################################################

### 1 ###

####################################################

# Function to setup hosts/add more machines
function setup_hosts_add_machines() {
    while true; do
        printf "This option allows you to add more machines to your Ansible 'hosts.yaml' file.\n"
        echo ""
        read -p "Do you want to proceed with adding a new machine to the hosts file? (yes/no) " proceed

        if [[ "$proceed" == "yes" ]] || [[ "$proceed" == "y" ]]; then
            # Run the updateHosts.sh script
            bash "$DIRECTORY_LOCATION/Wolflith/PCSMenu/Functions/Ansible/updateHosts.sh"

            # Ask if the user wants to add another machine
            echo ""
            read -p "Do you want to add another machine? (yes/no) " add_more
            if [[ "$add_more" != "yes" ]] && [[ "$add_more" != "y" ]]; then
                break
            fi
        else
            printf "\nAction canceled.\n"
            break
        fi
    done

    printf "\nReturning to Ansible menu...\n"
    sleep 2
    clear
    ansible
}

# --------------------------------------------------------------- #

####################################################

### 2 ###

####################################################

# Define the function
# Function to setup new machines
function new_machine_setup() {

    printf "This script is an automation tool that runs several Ansible playbooks in order to set up a new machine. The playbooks perform various tasks such as updating the package cache and installed packages, configuring time synchronization, installing and configuring the fail2ban package, creating a user and directory on the host machine, upgrading and installing the ansible package, installing specified ansible collections, setting up Oh-My-Zsh on the host machine, cloning a Git repository, and adding execute permissions to bash files.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Run the NewMachines.sh script
        bash "$DIRECTORY_LOCATION/Wolflith/Scripts/Ansible/FirstTimeSetup/NewMachines.sh"

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------"
    echo ""

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        ansible
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            ansible_banner
            new_machine_setup
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            ansible_banner
            new_machine_setup
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

# Define the function
function kubernetes_setup() {
    printf "This command is running an Ansible playbook, which is a script written in the Ansible automation language that defines a set of tasks to be executed, to install the k3s software on a server. The playbook is located at $DIRECTORY_LOCATION/Wolflith/Ansible/k3s/site.yml, and the command specifies a host inventory file, $DIRECTORY_LOCATION/Wolflith/Ansible/k3s/inventory/sample/hosts.ini, which contains a list of servers that the playbook will be run on.\n"
    echo ""
    printf "Make sure to have $DIRECTORY_LOCATION/Wolflith/Ansible/k3s/inventory/sample/hosts.ini configured before running this command.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Run Ansible playbook to install k3s
        ansible-playbook "$DIRECTORY_LOCATION/Wolflith/Ansible/k3s/site.yml" -i "$DIRECTORY_LOCATION/Wolflith/Ansible/k3s/inventory/sample/hosts.ini"

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"
    echo ""
    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        ansible
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            ansible_banner
            kubernetes_setup
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            ansible_banner
            kubernetes_setup
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 4 ###

####################################################

# Define the function
function kubernetes_cluster_access() {
    printf "This code extracts the IP addresses from the [master] section of a hosts file, displays them as options for the user to choose from, and runs the scp command with the selected IP. The select command allows the user to choose an option from a list of choices by entering the corresponding number. If the user enters an invalid selection, the script will display an error message and prompt the user to select again.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""
    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        bash "$DIRECTORY_LOCATION/Wolflith/Scripts/Ansible/FirstTimeSetup/K3sExtract-ip-addresses-and-scp.sh"

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
        ansible
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            ansible_banner
            kubernetes_cluster_access
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            ansible_banner
            kubernetes_cluster_access
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 5 ###

####################################################

# Define the function
function kubernetes_cluster_test() {
    printf "This is a bash script that extracts the VIP address from the apiserver_endpoint line in a all.yml file, pings the VIP address, and gets the nodes in a Kubernetes cluster. The script is intended for troubleshooting purposes, and the commands it runs are described in the comments above the commands in the file.\n"
    echo ""
    printf "CONFIGURE "$DIRECTORY_LOCATION/Wolflith/Ansible/k3s/inventory/sample/group_vars/all.yml" before running this command!\n"
    echo ""
    printf "Follow the video tutorial at https://youtu.be/CbkEWcUZ7zM?t=393 to configure the file.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        bash "$DIRECTORY_LOCATION/Wolflith/Scripts/Ansible/FirstTimeSetup/K3sTest.sh"

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
        ansible
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            ansible_banner
            kubernetes_cluster_test
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            ansible_banner
            kubernetes_cluster_test
        fi
    fi
}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
