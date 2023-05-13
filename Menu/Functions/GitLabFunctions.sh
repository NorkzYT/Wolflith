#!/bin/bash

# PCSMenu GitLabFunctions.sh

#####################################################################################################################################################################

### GitLab Functions ###

#####################################################################################################################################################################

function gitlab_banner {
    printf "$Yellow"
    # Display a banner with the text "gitlab"
    cat <<"EOF"


   ____ _ _   _          _     
  / ___(_) |_| |    __ _| |__  
 | |  _| | __| |   / _` | '_ \ 
 | |_| | | |_| |__| (_| | |_) |
  \____|_|\__|_____\__,_|_.__/ 
                               

EOF
    printf "$Color_Off"
    printf "\n"
}

##### gitlab Menu Options #####
function gitlab_options() {

    printf "$Cyan"
    printf "1) A. GitLab Cheat Sheets"
    printf "$Color_Off"
    echo ""

}

####################################################

### 1 ###

####################################################

# Define the function
# Function to setup new machines
function gitlab_cheat_sheets() {

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
        printf "https://quickref.me/gitlab"
        echo ""
        printf "https://cheatography.com/tag/gitlab/"
        echo ""
        printf "https://about.gitlab.com/images/press/git-cheat-sheet.pdf"
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
        gitlab
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            gitlab_banner
            gitlab_cheat_sheets
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            gitlab_banner
            gitlab_cheat_sheets
        fi
    fi
}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
