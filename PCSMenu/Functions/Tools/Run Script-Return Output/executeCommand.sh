#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

function execute_linux_command_via_ansible() {
    default_menu_screen
    printf "This option will ask you which Linux command you want to run that returns an output. (e.g., lshw -c display)\n"
    while true; do
        read -p "Do you still want to run this command? (yes/no) " run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            read -p "Please enter the Linux command you wish to run: " user_command
            echo "Do you want to run the playbook for all machines listed in hosts.yaml? (y/n)"
            read -r run_for_all

            if [[ "$run_for_all" =~ ^[Yy]$ ]]; then
                ansible_playbook_targets="all"
            else
                echo "Enter the name of the machine you want to run the playbooks for:"
                read -r ansible_playbook_targets
            fi

            # Execute the Ansible playbook for the specified target(s), capturing output
            output=$(ansible-playbook /opt/wolflith/Ansible/playbooks/run-custom-command.yml -i "/opt/wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" --extra-vars "command_to_run='$user_command'" 2>&1)

            # Always display the output, regardless of playbook execution status
            echo "$output"

            if [[ $? -ne 0 ]]; then
                redprint "An error occurred during playbook execution."

                yellowprint "Error occurred, press 'x' to exit."
                read -n 1 -r key
                echo

                if [[ $key =~ ^[Xx]$ ]]; then
                    clear
                    tools_menu
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

            # Call the tools_menu function
            tools_menu

            break
        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            clear
            tools_menu
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
