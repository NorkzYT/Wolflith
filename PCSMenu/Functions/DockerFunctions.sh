#!/bin/bash

# PCSMenu DockerFunctions.sh

#####################################################################################################################################################################

### Docker Functions ###

#####################################################################################################################################################################

# Get the directory where the script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
DIRECTORY_LOCATION=$(cat "$SCRIPT_DIR/../../Scripts/directory_location.txt")

function docker_banner() {
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
    printf "1) A. Install Docker                   2) B. Update Docker"
    printf "\n"
    printf "3) C. Provision Docker Service(s)"
    printf "$Color_Off"
    echo ""

}

#### Functions SECTION ####

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

# --------------------------------------------------------------- #

####################################################

### 2 ###

####################################################

function docker_update() {
    cyanprint "This option will guide you through updating Docker on machine(s)."
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
            if ! output=$(ansible-playbook $DIRECTORY_LOCATION/Wolflith/Ansible/playbooks/docker-update.yml -i "$DIRECTORY_LOCATION/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" 2>&1); then
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

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

function provision_docker_compose_service() {
    printf "This option will guide you through provisioning Docker service(s) on a Linux Machine."
    echo ""
    while true; do
        read -p "Do you still want to run this command? (yes/no) " run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            echo "Do you want to run the playbook for all machines listed in hosts.yaml? (y/n)"
            read -r run_for_all

            if [[ "$run_for_all" =~ ^[Yy]$ ]]; then
                ansible_playbook_targets="all"
            else
                echo "Enter the name of the machine you want to run the playbooks for:"
                read -r ansible_playbook_targets
            fi

            # Run scripts
            bash "$DIRECTORY_LOCATION/Wolflith/PCSMenu/Functions/Docker/select_service.sh"
            bash "$DIRECTORY_LOCATION/Wolflith/PCSMenu/Functions/Docker/setup_service.sh"
            bash "$DIRECTORY_LOCATION/Wolflith/PCSMenu/Functions/Docker/provision_docker_service.sh"

            # Execute the Ansible playbook for the specified target(s), capturing output
            if ! output=$(ansible-playbook $DIRECTORY_LOCATION/Wolflith/Ansible/playbooks/provision-docker-service.yml -i "$DIRECTORY_LOCATION/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" 2>&1); then
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

            # Remove temporary files
            rm -f /tmp/selected_docker_service.txt
            rm -f /tmp/selected_docker_service_path.txt
            rm -f /tmp/provisioning_docker_service_vars.yml
            rm -f /tmp/env_vars_for_ansible.yml

            # Prompt at the end
            while true; do
                echo "Do you want to return to the main menu? [Y/y] or [X/x] to Exit."
                read -n 1 -r user_choice
                echo

                if [[ $user_choice =~ ^[Yy]$ ]]; then
                    clear
                    docker
                    return
                elif [[ $user_choice =~ ^[Xx]$ ]]; then
                    echo "Exiting..."
                    exit 0
                else
                    echo "Invalid choice, please choose [Y/y] to return or [X/x] to Exit."
                fi
            done

            break
        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            # Immediately return to the main menu
            clear
            docker
            return
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            docker_banner
            provision_docker_compose_service
        fi
    done
}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
