#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSMenu/src/PCSFunc.sh

function provision_docker_service() {
    default_menu_screen
    cyanprint "This option will guide you through selecting and provisioning Docker services to your machines."
    echo ""

    while true; do
        cyanprint "Do you still want to run this command? (yes/no) "
        read -rp "" run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            cyanprint "Enter the name of the machine you want to run the playbooks for:"
            read -r ansible_playbook_targets
            greenprint "Proceeding with the machine: $ansible_playbook_targets"

            export ANSIBLE_PLAYBOOK_TARGET="$ansible_playbook_targets"

            # Select the Docker service
            cyanprint "Selecting Docker service..."
            bash "/opt/Wolflith/PCSMenu/src/Functions/Docker/Scripts/selectService.sh"

            cyanprint "Configuring Docker service..."
            bash "/opt/Wolflith/PCSMenu/src/Functions/Docker/Scripts/provisionDockerService.sh"

            # Check if the .env is configured
            cyanprint "Have you configured the .env before trying to set up the service? [y/N]: "
            read -rp "" confirm_env
            if [[ "$confirm_env" =~ ^[Nn][Oo]?$ ]]; then
                magentaprint "Operation canceled. Please configure the .env file before proceeding."
                exit 2
                return
            fi

            # Execute the Ansible playbook
            export ANSIBLE_CONFIG=/opt/Wolflith/Ansible/inventory/ansible.cfg

            cyanprint "Executing Docker provisioning playbook for $ansible_playbook_targets..."
            if ! output=$(ansible-playbook /opt/Wolflith/Ansible/playbooks/provision-docker-service.yml -i "/opt/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" 2>&1); then
                redprint "An error occurred during playbook execution:"
                echo "$output"
                yellowprint "Press 'x' to exit."
                read -n 1 -r key
                if [[ $key =~ ^[Xx]$ ]]; then
                    clear
                    exit 2
                    return
                fi
            else
                greenprint "Playbook executed successfully."
            fi

            # Prompt to continue
            echo "Press 'c' to continue..."
            while read -r -n 1 key; do
                if [[ $key == c ]]; then
                    echo "Continuing..."
                    break
                else
                    echo "Press 'c' to continue..."
                fi
            done

            exit 2
        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            magentaprint "Operation canceled. Returning to the main menu..."
            exit 2
            return
        else
            invalid_answer
            clear
            provision_docker_service
        fi
    done
}

provision_docker_service
