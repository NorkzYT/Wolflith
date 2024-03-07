#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSRustMenu/src/PCSFunc.sh

function execute_linux_command_via_ansible() {
    default_menu_screen
    printf "This option will ask you which Linux command you want to run that returns an output. (e.g., lshw -c display)\n"
    while true; do
        read -rp "Do you still want to run this command? (yes/no) " run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            read -rp "Please enter the Linux command you wish to run: " user_command
            echo "Do you want to run the playbook for all machines listed in hosts.yaml? (y/n)"
            read -r run_for_all

            if [[ "$run_for_all" =~ ^[Yy]$ ]]; then
                ansible_playbook_targets="all"
            else
                echo "Enter the name of the machine you want to run the playbooks for:"
                read -r ansible_playbook_targets
            fi

            export ANSIBLE_CONFIG=/opt/Wolflith/Ansible/inventory/ansible.cfg

            # Execute the Ansible playbook for the specified target(s), capturing output
            if ! output=$(ansible-playbook /opt/Wolflith/Ansible/playbooks/run-custom-command.yml -i "/opt/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" --extra-vars "command_to_run='$user_command'" 2>&1); then
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
            echo "Invalid input. Please answer yes or no."
            # Assuming invalid_answer clears the screen and shows the menu again
            invalid_answer
            clear
            menu_cover
            execute_linux_command_via_ansible
        fi
    done
}

execute_linux_command_via_ansible
