#!/bin/bash

# PCSMenu KubernetesFunctions.sh

#####################################################################################################################################################################

### Kubernetes Functions ###

#####################################################################################################################################################################

function kubernetes_banner() {
    # Display a banner with the text "Kubernetes"
    printf "$Blue"
    cat <<"EOF"
  _  __     _                          _            
 | |/ /   _| |__   ___ _ __ _ __   ___| |_ ___  ___ 
 | ' / | | | '_ \ / _ \ '__| '_ \ / _ \ __/ _ \/ __|
 | . \ |_| | |_) |  __/ |  | | | |  __/ ||  __/\__ \
 |_|\_\__,_|_.__/ \___|_|  |_| |_|\___|\__\___||___/
                    
                                                    
EOF

    printf "$Color_Off"
    printf "\n"
}

function kubernetes_options() {

    printf "$Cyan"
    printf "1) A. Provision a new cluster     2) B. Get nodes"
    printf "\n"
    printf "3) C. Test Cluster                4) D. Remove k3s from all nodes"
    printf "$Color_Off"
    echo ""

}

# --------------------------------------------------------------- #

####################################################

### 1 ###

####################################################

function docker_install() {
    cyanprint "This option will guide you through installing Docker on machine(s)."
    echo ""

    while true; do
        cyanprint "Do you still want to run this command? (yes/no) "
        read -p "" run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            cyanprint "Do you want to run the playbook for all machines listed in hosts.yaml? (y/n)"
            read -r run_for_all

            if [[ "$run_for_all" =~ ^[Yy]$ ]]; then
                ansible_playbook_targets="all"
                greenprint "Proceeding with all machines..."
            else
                cyanprint "Enter the name of the machine you want to run the playbooks for:"
                read -r ansible_playbook_targets
                greenprint "Proceeding with the machine: $ansible_playbook_targets"
            fi

            cyanprint "Executing Playbook... (Please be patient, may take more than 10 minutes to complete)"
            # Execute the Ansible playbook for the specified target(s), capturing output
            if ! output=$(ansible-playbook $DIRECTORY_LOCATION/Wolflith/Ansible/playbooks/docker.yml -i "$DIRECTORY_LOCATION/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" 2>&1); then
                redprint "An error occurred during playbook execution:"
                echo "$output" # Display the captured error output

                yellowprint "Error occurred, press 'x' to exit."
                read -n 1 -r key
                echo

                if [[ $key =~ ^[Xx]$ ]]; then
                    clear
                    docker
                    return
                fi
            else
                greenprint "Playbook executed successfully."
            fi

            # Prompt at the end
            while true; do
                cyanprint "Do you want to return to the main menu? [Y/y] or [X/x] to Exit."
                read -n 1 -r user_choice
                echo

                if [[ $user_choice =~ ^[Yy]$ ]]; then
                    clear
                    return
                elif [[ $user_choice =~ ^[Xx]$ ]]; then
                    greenprint "Exiting..."
                    exit 0
                else
                    yellowprint "Invalid choice, please choose [Y/y] to return or [X/x] to Exit."
                fi
            done

        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            magentaprint "Operation canceled. Returning to the main menu..."
            clear
            docker
            return
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            docker_banner
            docker_install
        fi
    done
}

#####################################################################################################################################################################
