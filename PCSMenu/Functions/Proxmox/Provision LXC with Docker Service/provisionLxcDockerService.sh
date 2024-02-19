#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

function provision_docker_services_on_lxc() {
    default_menu_screen
    cyanprint "This option will guide you through provisioning Docker service(s) on a new LXC container within a Proxmox VE."
    echo ""

    while true; do
        cyanprint "Do you still want to run this command? (yes/no) "
        read -rp "" run_command
        echo ""

        if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
            cyanprint "Enter the name of the machine you want to run the playbooks for:"
            read -r ansible_playbook_targets
            greenprint "Proceeding with the machine: $ansible_playbook_targets"

            # Before calling provisionLxc.sh, export the target as an environment variable
            export ANSIBLE_PLAYBOOK_TARGET="$ansible_playbook_targets"

            # Run scripts with informative prompts
            cyanprint "Selecting Docker service..."
            bash "../../Docker/Scripts/selectService.sh"

            cyanprint "Setting up Docker service..."
            bash "../../Docker/Scripts/setupService.sh"

            cyanprint "Provisioning Docker service..."
            bash "../../Docker/Scripts/provisionDockerService.sh"

            cyanprint "Provisioning LXC container..."
            bash "../Scripts/provisionLxc.sh"

            cyanprint "Executing Playbook... (Please be patient, may take more than 10 minutes to complete)"
            # Execute the Ansible playbook for the specified target(s), capturing output
            if ! output=$(ansible-playbook /opt/wolflith/Ansible/playbooks/provision-proxmox-lxc.yml -i "/opt/wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" 2>&1); then
                redprint "An error occurred during playbook execution:"
                echo "$output" # Display the captured error output

                yellowprint "Error occurred, press 'x' to exit."
                read -n 1 -r key
                echo

                if [[ $key =~ ^[Xx]$ ]]; then
                    clear
                    docker_menu
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
            rm -f /tmp/lxc_provisioning_vars.yml

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

            # Call the proxmox_menu function
            proxmox_menu

        elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
            magentaprint "Operation canceled. Returning to the main menu..."
            proxmox_menu
            return
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            menu_cover
            provision_docker_services_on_lxc
        fi
    done
}

provision_docker_services_on_lxc
