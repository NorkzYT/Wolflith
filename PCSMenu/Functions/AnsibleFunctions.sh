#!/bin/bash

# PCSMenu AnsibleFunctions.sh

#####################################################################################################################################################################

### Ansible Functions ###

#####################################################################################################################################################################

function ansible_banner {
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
    printf "1) A. Setup New Machines                                  2) B. First Time Docker Setup"
    printf "\n"
    printf "3) C. Setup Kubernetes Cluster                            4) D. Accessing Kubernetes Cluster"
    printf "\n"
    printf "5) C. Testing Kubernetes Cluster"
    printf "$Color_Off"
    echo ""

}

#### Functions SECTION ####

# --------------------------------------------------------------- #

function ansible_message {
    printf "\nConfigure "Ansible/inventory/hosts" file before choosing any option, and for Kubernetes configure "Ansible/k3s/inventory/sample/hosts.ini", and "Ansible/k3s/inventory/sample/group_vars/all.yml"!\n\n"

}

####################################################

### 1 ###

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
        bash /home/user/Wolflith/Menu/Scripts/Ansible/FirstTimeSetup/NewMachines.sh

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

### 2 ###

####################################################

function first_docker_setup() {
    printf "This playbook makes a script called DockerContainerSetup.sh executable and then runs it. The tasks are run with elevated privileges using the sudo command, and the playbook will be applied to all hosts specified in the inventory. The script executed  installs and sets up various Docker containers on a machine by using the docker-compose command to bring up the containers in the background. The containers are located in the specified directories and are started in the following order: WatchTower, Tailscale, Syncthing, Portainer, Vscode, Authentik, Traefik, GitLab. The script also modifies the docker-compose.yml file in the Tailscale directory and runs a command inside the Tailscale container. The script ends with several commented lines that do not have any effect on the script's execution.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Installs all docker containers for new machines
        ansible-playbook /home/user/Wolflith/Ansible/playbooks/first-time-docker-container-setup.yml

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
            first_docker_setup

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            ansible_banner
            first_docker_setup
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

# Define the function
function kubernetes_setup() {
    printf "This command is running an Ansible playbook, which is a script written in the Ansible automation language that defines a set of tasks to be executed, to install the k3s software on a server. The playbook is located at /home/user/Wolflith/Ansible/k3s/site.yml, and the command specifies a host inventory file, /home/user/Wolflith/Ansible/k3s/inventory/sample/hosts.ini, which contains a list of servers that the playbook will be run on.\n"
    echo ""
    printf "Make sure to have /home/user/Wolflith/Ansible/k3s/inventory/sample/hosts.ini configured before running this command.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Run Ansible playbook to install k3s
        ansible-playbook /home/user/Wolflith/Ansible/k3s/site.yml -i /home/user/Wolflith/Ansible/k3s/inventory/sample/hosts.ini

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

        bash /home/user/Wolflith/Scripts/Ansible/FirstTimeSetup/K3sExtract-ip-addresses-and-scp.sh

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
    printf "CONFIGURE "/home/user/Wolflith/Ansible/k3s/inventory/sample/group_vars/all.yml" before running this command!\n"
    echo ""
    printf "Follow the video tutorial at https://youtu.be/CbkEWcUZ7zM?t=393 to configure the file.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        bash /home/user/Wolflith/Scripts/Ansible/FirstTimeSetup/K3sTest.sh

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
