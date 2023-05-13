#!/bin/bash

# PCSMenu MachineFunctions.sh

#####################################################################################################################################################################

### Machine Functions ###

#####################################################################################################################################################################

function machine_banner {
    printf "$White"
    # Display a banner with the text "Docker"
    cat <<"EOF"
    
  __  __            _     _            
 |  \/  | __ _  ___| |__ (_)_ __   ___ 
 | |\/| |/ _` |/ __| '_ \| | '_ \ / _ \
 | |  | | (_| | (__| | | | | | | |  __/
 |_|  |_|\__,_|\___|_| |_|_|_| |_|\___|
                                       

EOF
    printf "$Color_Off"
    printf "\n"
}

##### Machine Menu Options #####
function machine_options() {

    printf "$BGreen"
    printf "System Info:\n"
    printf "$Color_Off"
    printf "$Cyan"
    printf "1) A. Memory usage                        2) B. CPU load"
    printf "\n"
    printf "3) C. CPU Info                            4) D. Number of TCP connections"
    printf "\n"
    printf "5) E. Kernel version                      6) F. Check All"
    printf "$Color_Off"
    echo ""

}

#####################################################################################################################################################################

### Machine Sub_menu ###

machine() {

    menu_cover      # Declared Menu_Cover
    menu_bar        # Declared Menu_Bar
    machine_options # Shows Machine Info Options
    go_back_menu    # Line to go back to main menu
    exit_script     # Line to exit the script
    move_cursor     # Moves cursor
    input_color     # Changes input highlight color

    read a
    case $a in

    1)
        Color_Off
        sleep 0.2
        clear
        machine_banner
        sys_memory_check
        clear
        machine
        ;;
    2)
        Color_Off
        sleep 0.2
        clear
        machine_banner
        cpu_check
        clear
        machine
        ;;
    3)
        Color_Off
        sleep 0.2
        clear
        machine_banner
        cpu_info
        clear
        machine
        ;;
    4)
        Color_Off
        sleep 0.2
        clear
        machine_banner
        tcp_check
        clear
        machine
        ;;
    5)
        Color_Off
        sleep 0.2
        clear
        machine_banner
        kernel_check
        clear
        machine
        ;;
    6)
        Color_Off
        sleep 0.2
        clear
        machine_banner
        all_checks
        clear
        machine
        ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        machine
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

#### Functions SECTION ####

####################################################

### 1 ###

####################################################

# Define the function
function sys_memory_check() {

    printf "Prints separator line, displays message, runs 'free' command, and prints separator line\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        echo "--------------------------------------------------------------------------------"
        echo "Memory info in ${server_name} is: "
        free -h
        echo "--------------------------------------------------------------------------------"

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
        machine
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            machine_banner
            sys_memory_check
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            machine_banner
            sys_memory_check
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 2 ###

####################################################

# Define the function
function cpu_check() {

    printf "Prints separator line, displays message, prints empty line, runs 'uptime' command, and prints separator line\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        echo "--------------------------------------------------------------------------------"
        echo "CPU load in ${server_name} is: "
        echo ""
        uptime
        echo "--------------------------------------------------------------------------------"

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
        machine
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            machine_banner
            cpu_check
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            machine_banner
            cpu_check
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

# Define the function
function cpu_info() {

    printf "Prints separator line, displays message, prints empty line, runs 'cat /proc/cpuinfo', and prints separator line\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        echo "--------------------------------------------------------------------------------"
        echo "CPU info of ${server_name}: "
        echo ""
        cat /proc/cpuinfo
        echo "--------------------------------------------------------------------------------"

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
        machine
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            machine_banner
            cpu_info
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            machine_banner
            cpu_info
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 4 ###

####################################################

# Define the function
function tcp_check() {

    printf "Prints separator line, displays message, prints empty line, runs 'cat /proc/net/tcp | wc -l', and prints separator line\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        echo "--------------------------------------------------------------------------------"
        echo "TCP connections in ${server_name}: "
        echo ""
        cat /proc/net/tcp | wc -l
        echo "--------------------------------------------------------------------------------"

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
        machine
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            machine_banner
            tcp_check
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            machine_banner
            tcp_check
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 5 ###

####################################################

# Define the function
function kernel_check() {

    printf "Prints separator line, displays message, prints empty line, runs 'uname -r', and prints separator line\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        echo "--------------------------------------------------------------------------------"
        echo "Kernel version in ${server_name} is: "
        echo ""
        uname -r
        echo "--------------------------------------------------------------------------------"

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
        machine
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            machine_banner
            kernel_check
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            machine_banner
            kernel_check
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 6 ###

####################################################

# Define the function
function all_checks() {

    printf "Prints empty line, runs multiple functions, and prints empty line\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        echo "--------------------------------------------------------------------------------"
        echo "Memory info in ${server_name} is: "
        free -h
        echo "--------------------------------------------------------------------------------"
        echo "--------------------------------------------------------------------------------"
        echo "CPU load in ${server_name} is: "
        echo ""
        uptime
        echo "--------------------------------------------------------------------------------"
        echo "--------------------------------------------------------------------------------"
        echo "CPU info of ${server_name}: "
        echo ""
        cat /proc/cpuinfo
        echo "--------------------------------------------------------------------------------"
        echo "--------------------------------------------------------------------------------"
        echo "TCP connections in ${server_name}: "
        echo ""
        cat /proc/net/tcp | wc -l
        echo "--------------------------------------------------------------------------------"
        echo "--------------------------------------------------------------------------------"
        echo "Kernel version in ${server_name} is: "
        echo ""
        uname -r
        echo "--------------------------------------------------------------------------------"

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
        machine
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            machine_banner
            all_checks
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            machine_banner
            all_checks
        fi
    fi
}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
