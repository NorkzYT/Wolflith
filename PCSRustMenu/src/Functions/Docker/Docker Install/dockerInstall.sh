#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSRustMenu/src/PCSFunc.sh

function docker_install() {
    default_menu_screen
    cyanprint "This option will guide you through installing Docker on machine(s)."
    echo ""

    while true; do
        cyanprint "Do you still want to run this command? (yes/no) "
        read -rp "" run_command
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

            export ANSIBLE_CONFIG=/opt/Wolflith/Ansible/inventory/ansible.cfg

            cyanprint "Executing Playbook... (Please be patient, may take more than 10 minutes to complete)"
            # Execute the Ansible playbook for the specified target(s), capturing output
            if ! output=$(ansible-playbook /opt/Wolflith/Ansible/playbooks/docker.yml -i "/opt/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" 2>&1); then
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
            docker_install
        fi
    done
}

docker_install
