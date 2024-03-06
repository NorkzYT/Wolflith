#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSRustMenu/src/PCSFunc.sh

function provision_docker_compose_service() {
    default_menu_screen
    printf "This option will ask you which Linux command you want to run that returns an output."
    echo ""
    while true; do
        read -rp "Do you still want to run this command? (yes/no) " run_command
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

            # Execute the Ansible playbook for the specified target(s), capturing output
            if ! output=$(ansible-playbook /opt/Wolflith/Ansible/playbooks/run-custom-command.yml -i "/opt/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" --extra-vars "command_to_run='sudo lshw -c display'" 2>&1); then
                redprint "An error occurred during playbook execution:"
                echo "$output" # Display the captured error output

                yellowprint "Error occurred, press 'x' to exit."
                read -n 1 -r key
                echo

                if [[ $key =~ ^[Xx]$ ]]; then
                    clear
                    exit 2
                    return
                fi
            else
                greenprint "Playbook executed successfully."
            fi

            # Prompt at the end
            echo "Press 'c' to continue..."
            while read -r -n 1 key; do
                if [[ $key == c ]]; then
                    echo "Key 'c' pressed. Continuing..."
                    break
                else
                    echo "Press 'c' to continue..."
                fi
            done

            # Return to main menu
            exit 2

            break
        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            magentaprint "Operation canceled. Returning to the main menu..."
            sleep 1
            exit 2
            return
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            menu_cover
            provision_docker_compose_service
        fi
    done
}

provision_docker_compose_service
