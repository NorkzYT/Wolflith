#!/bin/bash

# PCSMenu GitHubFunctions.sh

#####################################################################################################################################################################

### GitHub Functions ###

#####################################################################################################################################################################

function github_banner {
    printf "$Purple"
    # Display a banner with the text "Github"
    cat <<"EOF"

   ____ _ _   _   _       _     
  / ___(_) |_| | | |_   _| |__  
 | |  _| | __| |_| | | | | '_ \ 
 | |_| | | |_|  _  | |_| | |_) |
  \____|_|\__|_| |_|\__,_|_.__/ 
                                 
EOF
    printf "$Color_Off"
    printf "\n"
}

##### GitHub Menu Options #####
function github_options() {

    printf "$Cyan"
    printf "1) A. Git Cheat Sheet"
    printf "$Color_Off"
    echo ""

}

####################################################

### 1 ###

####################################################

# Define the function
# Function to setup new machines
function git_cheat_sheet() {

    printf "This command gives you a cheat sheet for Git commands.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Run the NewMachines.sh script
        printf "Here you go mate."
        echo ""
        printf "$Cyan"
        printf "https://education.github.com/git-cheat-sheet-education.pdf"
        printf "$Color_Off"

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
        github
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            github_banner
            git_cheat_sheet
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            github_banner
            git_cheat_sheet
        fi
    fi
}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
