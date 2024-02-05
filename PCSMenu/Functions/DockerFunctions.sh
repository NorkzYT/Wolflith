#!/bin/bash

# PCSMenu DockerFunctions.sh

#####################################################################################################################################################################

### Docker Functions ###

#####################################################################################################################################################################

function docker_banner {
    printf "$Cyan"
    # Display a banner with the text "Docker"
    cat <<"EOF"
    ____             __      
   / __ \____  _____/ /_____  ______
  / / / / __ \/ ___/ //_/ _ \/ ___/ 
 / /_/ / /_/ / /__/ ,< /  __/ /
/_____/\____/\___/_/|_|\___/_/      
                                                                
EOF
    printf "$Color_Off"
    printf "\n"
}

##### Docker Menu Options #####
function docker_options() {

    printf "$Cyan"
    printf "1) A. Install Docker                                   2) B. Manual Command"
    printf "\n"
    printf "3) C. Total Docker Container Memory Usage              4) D. Remove all unused Docker data"
    printf "$Color_Off"
    echo ""

}

#### Functions SECTION ####

# --------------------------------------------------------------- #

####################################################

### 1 ###

####################################################

# Define the function
# Function to get total memory usage of all Docker containers
function docker_memory_check() {

    printf "This script displays the total memory usage of all Docker containers on the system. It first gets the total memory amount and the unit of measurement, calculates the total memory usage percentage and the total memory usage, and then calculates the difference between the total memory amount and the total memory usage. Finally, it displays the total memory amount, the total memory usage, the total memory usage percentage, and the difference between the total memory amount and the total memory usage.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Run the DockerContainerMem.sh script
        bash /home/user/Wolflith/Scripts/Menu/Auto/DockerContainerMem.sh
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
        docker
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            docker_banner
            docker_memory_check
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            docker_banner
            docker_memory_check
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 2 ###

####################################################

function docker_install() {
    printf "This script installs and configures Docker and Docker Compose on an Ubuntu system. It first checks if Docker and Docker Compose are already installed and, if they are, displays a message and the version of Docker. If either Docker or Docker Compose is not installed, the script updates the system and installs the required packages. It then prints the version of Docker and Docker Compose to confirm successful installation.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Run the DockerInstaller.sh script
        bash /home/user/Wolflith/Scripts/Menu/Auto/DockerInstaller.sh
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
        docker
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            docker_banner
            docker_install

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            docker_banner
            docker_install
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

# Define the function
function run_docker_command() {
    printf "This script checks if Docker and Docker Compose are installed on the system. If they are, it prompts the user for a Docker command to run and then executes it. If Docker and Docker Compose are not installed, it tells the user to install them first.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Run the DockerManualCommand.sh script
        bash /home/user/Wolflith/Scripts/Menu/Auto/DockerManualCommand.sh
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
        docker
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            docker_banner
            run_docker_command
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            docker_banner
            run_docker_command
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 4 ###

####################################################

# Define the function
function rm_unused_resources() {
    printf "\nThis command removes all unused Docker resources, including containers, images, and volumes.\n"
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""
    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        docker system prune -a --volumes
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
        docker
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            docker_banner
            rm_unused_resources
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            docker_banner
            rm_unused_resources
        fi
    fi
}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
