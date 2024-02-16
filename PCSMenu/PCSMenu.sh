#!/bin/bash

######################################################################
# Title   : PCSCORPMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source "$(dirname "$0")/PCSFunc.sh"

# Global Variables
BASE_DIR="Functions"
CURRENT_DIR="$BASE_DIR"
PARENT_DIR=""
SELECTION=""
declare -a DIRECTORIES
declare -a FILES

clear_screen() {
    clear
}

run_script() {
    local script_path="$1"
    if [[ -f "$script_path" ]]; then
        source "$script_path"
        if type main &>/dev/null; then
            main
        else
            echo "No 'main' function found in $script_path" >&2
        fi
    else
        echo "Script not found: $script_path" >&2
    fi
}

list_directories_and_files() {
    local dir="$1"
    DIRECTORIES=() # Reset DIRECTORIES array before listing
    FILES=()       # Reset FILES array before listing
    local content_found=false
    local blacklist="Scripts" # Define the directory to be excluded

    # Check for subdirectories
    while IFS= read -r line; do
        if [[ "$(basename "$line")" != "$blacklist" ]]; then
            DIRECTORIES+=("$line")
            content_found=true
        fi
    done < <(find "$dir" -maxdepth 1 -mindepth 1 -type d | sort)

    # If no subdirectories are found, check for scripts directly under the directory
    if ! $content_found; then
        while IFS= read -r line; do
            FILES+=("$line")
            content_found=true
        done < <(find "$dir" -maxdepth 1 -type f -name "*.sh" | sort)
    fi

    # If exactly one script is found in the directory, run it
    if [[ ${#FILES[@]} -eq 1 ]]; then
        run_script "${FILES[0]}"
        FILES=()
        DIRECTORIES=()
    fi
}

display_menu() {
    local i=1
    echo "Enter a number to select an option:"
    for dir in "${DIRECTORIES[@]}"; do
        echo "$i) $(basename "$dir")"
        ((i++))
    done
    echo "B) Back"
    echo "X) Exit"
}

navigate() {
    if [[ "$SELECTION" =~ ^[0-9]+$ ]]; then
        local index=$((SELECTION - 1))
        if [[ $index -lt ${#DIRECTORIES[@]} ]]; then
            PARENT_DIR="$CURRENT_DIR"
            CURRENT_DIR="${DIRECTORIES[$index]}"
            list_directories_and_files "$CURRENT_DIR"
        else
            echo "Invalid selection." >&2
            return
        fi
    elif [[ "$SELECTION" == "B" || "$SELECTION" == "b" ]]; then
        if [[ "$CURRENT_DIR" != "$BASE_DIR" ]]; then
            CURRENT_DIR="$PARENT_DIR"
            PARENT_DIR=$(dirname "$PARENT_DIR")
        fi
    elif [[ "$SELECTION" == "X" || "$SELECTION" == "x" ]]; then
        echo "Exiting..."
        clear
        exit 0
    else
        echo "Invalid selection." >&2
        return
    fi
} 

reset_navigation_state() {
    CURRENT_DIR="$1"
    PARENT_DIR="$2"
}

ansible_menu() {
    reset_navigation_state "$BASE_DIR/Ansible" "$BASE_DIR"
    list_directories_and_files "$CURRENT_DIR"
}

docker_menu() {
    reset_navigation_state "$BASE_DIR/Docker" "$BASE_DIR"
    list_directories_and_files "$CURRENT_DIR"
}

proxmox_menu() {
    reset_navigation_state "$BASE_DIR/Proxmox" "$BASE_DIR"
    list_directories_and_files "$CURRENT_DIR"
}

tools_menu() {
    reset_navigation_state "$BASE_DIR/Tools" "$BASE_DIR"
    list_directories_and_files "$CURRENT_DIR"
}

main() {
    while true; do
        default_menu_screen
        list_directories_and_files "$CURRENT_DIR"
        if [[ ${#DIRECTORIES[@]} -eq 0 && ${#FILES[@]} -eq 0 ]]; then
            echo "No options available."
            display_menu # To show Back and Exit options
        else
            display_menu
        fi
        read -rp "Enter 1-${#DIRECTORIES[@]}, B for going back up a level or X for Exit: " SELECTION
        navigate
    done
}

main
