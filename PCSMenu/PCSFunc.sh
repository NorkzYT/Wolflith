#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSRustMenu/src/PersonalizationFunc.sh

# Global variables for cache files and their lifetimes
CACHE_DIR="/opt/Wolflith/Temp/PCSMenuCache"
PUBLIC_IP_CACHE="$CACHE_DIR/public_ip.cache"
CACHE_LIFETIME=3600 # 1 hour in seconds

mkdir -p "$CACHE_DIR"

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
    latest_version=$(curl -s "https://api.github.com/repos/NorkzYT/Wolflith/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
    printf "$BCyan"
    echo "
  _____   _____  _____  _____ ____  _____  _____  ™
 |  __ \ / ____|/ ____|/ ____/ __ \|  __ \|  __ \ 
 | |__) | |    | (___ | |   | |  | | |__) | |__) |
 |  ___/| |     \___ \| |   | |  | |  _  /|  ___/ 
 | |    | |____ ____) | |___| |__| | | \ \| |     
 |_|     \_____|_____/ \_____\____/|_|  \_\_|      Version: $latest_version
"
    printf "${Color_Off}"
}

# check if pcsmenu is up-to-date
check_update() {
    local last_checked_file="/opt/Wolflith/Temp/last_checked.txt"
    local current_date
    current_date=$(date +%Y-%m-%d)

    # Check if the last_checked_file exists, create it if not
    if [ ! -f "$last_checked_file" ]; then
        echo "Creating $last_checked_file and setting last checked date to $current_date"
        mkdir -p "$(dirname "$last_checked_file")" # Ensure the directory exists
        echo "$current_date" >"$last_checked_file"
    fi

    local last_checked
    last_checked=$(cat "$last_checked_file" 2>/dev/null)

    if [[ "$last_checked" != "$current_date" ]]; then
        echo "$current_date" >"$last_checked_file"
        current_version=$(grep 'Version:' "/opt/Wolflith/PCSRustMenu/src/PCSFunc.sh" | sed -E 's/.*Version: (.*)$/\1/')
        latest_version=$(curl -s "https://api.github.com/repos/NorkzYT/Wolflith/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')
        if [ "$current_version" != "$latest_version" ]; then
            blueprint "Your PCSMenu is not up-to-date. Use 'pcsupdate' to update."
        fi
    fi
}

function os_release() {
    local dist=""
    local release=""
    local pretty_name=""

    if [ -f /etc/os-release ]; then
        # Source the os-release file
        . /etc/os-release
        pretty_name=$PRETTY_NAME
    elif type lsb_release >/dev/null 2>&1; then
        # Fallback to lsb_release if os-release is not available
        dist=$(lsb_release -si)
        release=$(lsb_release -sr)
        pretty_name="${dist} ${release}"
    elif [ -f /etc/lsb-release ]; then
        # Fallback to sourcing lsb-release
        . /etc/lsb-release
        dist=$DISTRIB_ID
        release=$DISTRIB_RELEASE
        pretty_name="${dist} ${release}"
    elif [ -f /etc/debian_version ]; then
        # Specific fallback for Debian to identify the version
        dist="Debian"
        release=$(cat /etc/debian_version)
        pretty_name="${dist} ${release}"
    else
        # Generic fallback to system information
        dist=$(uname -s)
        release=$(uname -r)
        pretty_name="${dist} ${release}"
    fi

    # Print the pretty name of the OS if available or construct it from dist and release
    printf "%s" "${pretty_name}"
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

# Function to get or update the cached public IP
get_or_update_public_ip() {
    local current_time
    current_time=$(date +%s)
    local update_cache=1

    # Check if the cache file exists and its timestamp
    if [[ -f "$PUBLIC_IP_CACHE" ]]; then
        local last_update
        last_update=$(stat -c %Y "$PUBLIC_IP_CACHE")
        local age=$((current_time - last_update))

        if [[ $age -lt $CACHE_LIFETIME ]]; then
            update_cache=0
        fi
    fi

    if [[ $update_cache -eq 1 ]]; then
        # Update cache with new IP
        local new_ip
        new_ip=$(curl -s https://api.ipify.org)
        echo "$new_ip" >"$PUBLIC_IP_CACHE"
    fi

    cat "$PUBLIC_IP_CACHE"
}

function date_time() {
    date +"%D %T"
}

### Modified Menu_Bar ###
function menu_bar() {

    # Extract the first IPv4 address (assuming it's the first one listed by `hostname -I`)
    ipv4=$(hostname -I | awk '{print $1}')

    # Search for a Tailscale IP address in the `100.x.y.z` range
    tailscale_ip=$(hostname -I | grep -oP '100\.\d+\.\d+\.\d+')

    # Get or update the public IP from the cache
    public_ip=$(get_or_update_public_ip)

    # Assuming the rest of the data doesn't change frequently either, consider caching if necessary
    cpu_s=$(lscpu | grep "CPU(s):" | tail +1 | head -1 | awk '{print $2}')
    cpu_threads=$(threads_pc)
    ram_free=$(memory)
    os_info=$(os_release)

    printf "$BCyan"
    printf "%s" "OS: $os_info"
    printf " |"
    printf "%s" " CPU(s): $cpu_s"
    printf " |"
    printf "%s" " CPU Threads: $cpu_threads"
    printf " |"
    printf "%s" " IPv4: $ipv4"
    printf " |"
    printf "%s" " Public IP: $public_ip"
    if [[ -n "$tailscale_ip" ]]; then
        printf " |"
        printf "%s" " Tailscale IP: $tailscale_ip"
    fi
    printf " |"
    printf "%s" " RAM free: ${ram_free} GB"
    echo "" # | echo - ne "" | Removes a line for code to be on the line before it.
    echo ""
    printf "$Color_Off"
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
    sleep 1
    clear
}
