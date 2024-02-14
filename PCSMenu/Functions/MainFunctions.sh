#!/bin/bash

# PCSMenu MainFunctions.sh

#####################################################################################################################################################################

### Main Functions ###

#####################################################################################################################################################################

function os_release() {
    (
        . /etc/os-release
        printf "${RED}$PRETTY_NAME"
    )
}

# Define the function
function threads_pc() {
    # Get the number of CPU cores
    cores=$(nproc --all)

    # Multiply the number of cores by 2 to get the number of threads
    threads=$((cores * 2))

    # Print the number of threads
    echo "$threads"
}

function memory() {
    # Print the value of the "available" column in gigabytes.
    free -m | awk 'FNR == 2 {print $7/1024}'
}

# Function to show the public IP address of the device
show_ip() {
    # Get the public IP address
    ip_address=$(dig +short myip.opendns.com @resolver1.opendns.com)

    # Display the public IP address
    echo "${ip_address}"
}

function date_time() {
    date +"%D %T"
}

function github_version() {
    printf "0.0.1"
}

### Modified Menu_Bar ###
function menu_bar() {
    os_release
    printf " |"
    printf " Cpu Threads: $(threads_pc)"
    printf " |"
    printf " IP: $(show_ip)"
    printf " |"
    printf " RAM free: $(memory)MB"
    echo "" # | echo - ne "" | Removes a line for code to be on the line before it.
    echo ""

}

### Main Menu Options ###
function main_options() {

    printf "$Cyan"
    printf "1) A. Linux        2) B. Proxmox   3) C. Docker"
    printf "\n"
    printf "4) D. Ansible      5) E. Github    6) F. GitLab"
    printf "\n"
    printf "7) G. Tools"
    printf "$Color_Off"
    echo ""

}

### Cursor placement/Main ###
function move_cursor() { # With color

    # Text color
    printf "$BWhite"

    # Move the cursor to the right by one slot
    tput cuf 1

    # Saves cursor location
    tput sc

}

### Go Back Function ###
function go_back_menu() {

    echo ""
    printf "$BRed"
    printf "B) Go Back to the Main Menu"
    printf "$Color_Off"

}

### Option number amount ###
function option_number() {
    case $CURRENT_MENU in
    "Main") printf "1-7" ;;
    "Linux") printf "1-55" ;;
    "Proxmox") printf "1-26" ;;
    "Docker") printf "1-3" ;;
    "Ansible") printf "1-2" ;;
    "GitHub") printf "1-1" ;;
    "GitLab") printf "1-1" ;;
    "Tools") printf "1-1" ;;
    *) printf "1-6" ;;
    esac
}

### Exit Function for main ###
function exit_script_main() {

    echo ""
    printf "$Cyan"
    printf "Enter $(option_number) or X for Exit:"
    printf "$Color_Off"

}

### Exit Function for all else ###
function exit_script() {

    echo ""
    printf "$Cyan"
    printf "Enter $(option_number), B for going back a level or X for Exit:"
    printf "$Color_Off"

}

### Turn Color off, Exit code after 1 second and clear screen ###
function exit_cmd() {

    printf "$(Color_Off)"
    echo "Exiting..."
    sleep 1
    clear
    exit 0

}

### Turn color OFF ###
function Color_Off() {

    printf "$Color_Off"

}

### Input Highlight/Backround Color ###
function input_color() {
    # Backround color
    printf "$On_Cyan"

}

### Invalid input ###
function invalid_input() {
    echo "Invalid Option, try again."
    sleep 1
    clear
}

### Invalid key ###
function invalid_answer() {
    echo "Invalid answer. Please enter 'yes' or 'no'."
    sleep 2
    clear
}

#####################################################################################################################################################################
