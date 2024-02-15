#!/bin/bash

# PCSMenu AnsibleFunctions.sh

#####################################################################################################################################################################

### Ansible Functions ###

#####################################################################################################################################################################

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DIRECTORY_LOCATION=$(cat "$SCRIPT_DIR/../../Temp/directory_location.txt")

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
    printf "1) Setup Hosts/Add More Machines                             2) Setup New Linux Machines"
    printf "$Color_Off"
    echo ""
}

#### Functions SECTION ####

# --------------------------------------------------------------- #

function ansible_message() {
    printf "\nConfigure "Ansible/inventory/hosts.yaml" with the first option before choosing any other options!\n\n"

}

####################################################

### 1 ###

####################################################

# Function to setup hosts/add more machines
function setup_hosts_add_machines() {
    printf "This option allows you to add more machines to your Ansible 'hosts.yaml' file.\n"
    echo ""
    while true; do
        read -p "Do you want to proceed with adding a new machine to the hosts file? (yes/no) " proceed
        echo ""

        if [[ "$proceed" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            # Run the updateHosts.sh script
            bash "$DIRECTORY_LOCATION/Wolflith/PCSMenu/Functions/Ansible/updateHosts.sh"

            echo ""
            read -p "Do you want to add another machine? (yes/no) " add_more
            if ! [[ "$add_more" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
                break
            fi

        elif [[ "$proceed" =~ ^[Nn][Oo]?$ ]]; then
            # Immediately return to the main menu
            clear
            ansible
            return # Ensure no further code in this function is executed
        else
            # User entered an invalid answer
            invalid_answer
            clear
            ansible_banner
            setup_hosts_add_machines
        fi
    done

}

# --------------------------------------------------------------- #

####################################################

### 2 ###

####################################################

# Define the function
# Function to setup new machines
function new_machine_setup() {

    printf "This script is an automation tool that runs several Ansible playbooks in order to set up a new Linux Machine. The playbooks perform various tasks such as updating the package cache and installed packages, configuring time synchronization, installing and configuring the fail2ban package, creating a user on the host machine, and setting up Oh-My-Zsh on the host machine.\n"
    echo ""
    while true; do
        read -p "Do you still want to run this command? (yes/no) " run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            # Run the setupLinuxMachine.sh script
            bash "$DIRECTORY_LOCATION/Wolflith/PCSMenu/Functions/Ansible/setupLinuxMachine.sh"

            # Prompt at the end
            while true; do
                echo "Do you want to return to the main menu? [Y/y] or [X/x] to Exit."
                read -n 1 -r user_choice
                echo

                if [[ $user_choice =~ ^[Yy]$ ]]; then
                    clear
                    ansible
                    return
                elif [[ $user_choice =~ ^[Xx]$ ]]; then
                    echo "Exiting..."
                    exit 0
                else
                    echo "Invalid choice, please choose [Y/y] to return or [X/x] to Exit."
                fi
            done

            break
        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            # Immediately return to the main menu
            clear
            ansible
            return # Ensure no further code in this function is executed
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            ansible_banner
            new_machine_setup
        fi
    done
}

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

# --------------------------------------------------------------- #

#####################################################################################################################################################################
