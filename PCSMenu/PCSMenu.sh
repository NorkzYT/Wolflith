#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

# Import the Personalization Functions for color and styling
source /opt/wolflith/PCSMenu/PCSFunc.sh

# Global Variables
BASE_DIR="Functions"
CURRENT_DIR="$BASE_DIR"
PARENT_DIR=""
SELECTION=""
declare -a DIRECTORIES
declare -a FILES

# Clear the screen
clear_screen() {
    clear
}

# Run a selected script
run_script() {
    local script_path="$1"
    if [[ -f "$script_path" ]]; then
        source "$script_path"
        if type main &>/dev/null; then
            main
        else
            redprint "No 'main' function found in $script_path"
        fi
    else
        redprint "Script not found: $script_path"
    fi
}

# List directories and files in the current directory
list_directories_and_files() {
    local dir="$1"
    DIRECTORIES=() # Reset DIRECTORIES array
    FILES=()       # Reset FILES array
    local content_found=false
    local blacklist="Scripts" # Directory to exclude

    # Listing subdirectories
    while IFS= read -r line; do
        if [[ "$(basename "$line")" != "$blacklist" ]]; then
            DIRECTORIES+=("$line")
            content_found=true
        fi
    done < <(find "$dir" -maxdepth 1 -mindepth 1 -type d | sort)

    # Listing scripts if no subdirectories found
    if ! $content_found; then
        while IFS= read -r line; do
            FILES+=("$line")
            content_found=true
        done < <(find "$dir" -maxdepth 1 -type f -name "*.sh" | sort)
    fi

    # Automatically run a script if it's the only file in the directory
    if [[ ${#FILES[@]} -eq 1 ]]; then
        run_script "${FILES[0]}"
        FILES=()
        DIRECTORIES=()
    fi
}

# Display the menu options horizontally
display_menu() {
    local i=1
    for dir in "${DIRECTORIES[@]}"; do
        echo -n $(yellowprint "$i) $(basename "$dir")  ")
        ((i++))
    done
    echo -n $(magentaprint "  B) Back  ")
    echo $(cyanprint "X) Exit")
}

# Navigate through the menu
navigate() {
    if [[ "$SELECTION" =~ ^[0-9]+$ ]]; then
        local index=$((SELECTION - 1))
        if [[ $index -lt ${#DIRECTORIES[@]} ]]; then
            PARENT_DIR="$CURRENT_DIR"
            CURRENT_DIR="${DIRECTORIES[$index]}"
            list_directories_and_files "$CURRENT_DIR"
        else
            redprint "Invalid selection."
            return
        fi
    elif [[ "$SELECTION" == "B" || "$SELECTION" == "b" ]]; then
        if [[ "$CURRENT_DIR" != "$BASE_DIR" ]]; then
            CURRENT_DIR="$PARENT_DIR"
            PARENT_DIR=$(dirname "$PARENT_DIR")
        fi
    elif [[ "$SELECTION" == "X" || "$SELECTION" == "x" ]]; then
        greenprint "Exiting..."
        clear_screen
        exit 0
    else
        redprint "Invalid selection."
        return
    fi
}

# Reset navigation state to a specific directory
reset_navigation_state() {
    CURRENT_DIR="$1"
    PARENT_DIR="$2"
}

# Specific menu functions for different categories
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

# Main loop for the menu
main() {
    check_update
    while true; do
        default_menu_screen
        list_directories_and_files "$CURRENT_DIR"
        if [[ ${#DIRECTORIES[@]} -eq 0 && ${#FILES[@]} -eq 0 ]]; then
            redprint "No options available."
            display_menu # To show Back and Exit options
        else
            display_menu
        fi
        echo ""
        read -rp "Enter 1-${#DIRECTORIES[@]}, B for going back up a level or X for Exit: " SELECTION
        navigate
    done
}
main
