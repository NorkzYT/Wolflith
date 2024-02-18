#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/wolflith/PCSMenu/PersonalizationFunc.sh

# Clear the screen
clear_screen() {
    clear
}

function default_menu_screen() {
    clear_screen
    menu_cover
    menu_bar

}

### Main Menu Cover ###
function menu_cover() {
    # Fetch the latest version from GitHub releases
    latest_version=$(curl -s "https://api.github.com/repos/NorkzYT/wolflith/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    printf "$BCyan
  _____   _____  _____  _____ ____  _____  _____  ™
 |  __ \ / ____|/ ____|/ ____/ __ \|  __ \|  __ \ 
 | |__) | |    | (___ | |   | |  | | |__) | |__) |
 |  ___/| |     \___ \| |   | |  | |  _  /|  ___/ 
 | |    | |____ ____) | |___| |__| | | \ \| |     
 |_|     \_____|_____/ \_____\____/|_|  \_\_|      Version: $latest_version
 
"
    printf "$Color_Off"
}

# check if pcsmenu is up-to-date
check_update() {
    local last_checked_file="/opt/wolflith/Temp/last_checked.txt"
    local current_date=$(date +%Y-%m-%d)
    local last_checked=$(cat "$last_checked_file" 2>/dev/null)

    if [[ "$last_checked" != "$current_date" ]]; then
        echo $current_date >"$last_checked_file"
        current_version=$(grep 'Version:' "/opt/wolflith/PCSMenu/PCSFunc.sh" | sed -E 's/.*Version: (.*)$/\1/')
        latest_version=$(curl -s "https://api.github.com/repos/NorkzYT/wolflith/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
        if [ "$current_version" != "$latest_version" ]; then
            blueprint "Your PCSMenu is not up-to-date. Use 'pcsupdate' to update."
        fi
    fi
}

function os_release() {
    (
        if [ -f /etc/os-release ]; then
            . /etc/os-release
            dist=$NAME
            release=$VERSION_ID
        elif type lsb_release >/dev/null 2>&1; then
            dist=$(lsb_release -si)
            release=$(lsb_release -sr)
        elif [ -f /etc/lsb-release ]; then
            . /etc/lsb-release
            dist=$DISTRIB_ID
            release=$DISTRIB_RELEASE
        elif [ -f /etc/debian_version ]; then
            dist=Debian
            release=$(cat /etc/debian_version)
        else
            dist=$(uname -s)
            release=$(uname -r)
        fi
        printf "$PRETTY_NAME"
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

### Modified Menu_Bar ###
function menu_bar() {
    printf "$BCyan"
    os_release
    printf " |"
    printf " Cpu Threads: $(threads_pc)"
    printf " |"
    printf " IP: $(show_ip)"
    printf " |"
    printf " RAM free: $(memory)MB"
    echo "" # | echo - ne "" | Removes a line for code to be on the line before it.
    echo ""
    printf "$Color_Off"
}

### Main Menu Options ###
function main_options() {

    printf "$Cyan"
    printf "1) A. Linux        2) B. Proxmox   3) C. Docker"
    printf "\n"
    printf "4) D. Ansible      5) E. Tools"
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

function ansible_message() {
    printf "\nConfigure "Ansible/inventory/hosts.yaml" with the second option before choosing any other options!\n\n"

}
