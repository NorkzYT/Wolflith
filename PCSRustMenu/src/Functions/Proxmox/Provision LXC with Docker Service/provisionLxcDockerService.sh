#!/bin/bash
######################################################################
# Title   : PCSMenu
# By      : NorkzYT
# License : General Public License GPL-3.0-or-later
######################################################################

source /opt/Wolflith/PCSRustMenu/src/PCSFunc.sh

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
            bash "/opt/Wolflith/PCSRustMenu/src/Functions/Docker/Scripts/selectService.sh"

            cyanprint "Setting up Docker service..."
            while true; do
                cyanprint "Have you configured the .env before trying to setup the service? [y/N]: "
                read -rp "" run_command

                if [[ "$run_command" =~ ^[Yy][Ee]?[Ss]?$ ]]; then
                    # Continue with the setup as the .env file is configured
                    break
                elif [[ "$run_command" =~ ^[Nn][Oo]?$ ]]; then
                    # Operation canceled by the user, return to the main menu
                    magentaprint "Operation canceled. Returning to the main menu..."
                    sleep 1
                    exit 2
                    return
                else
                    # The user entered an invalid answer
                    invalid_answer
                    clear
                    menu_cover
                fi
            done

            cyanprint "Provisioning Docker service..."
            bash "/opt/Wolflith/PCSRustMenu/src/Functions/Docker/Scripts/provisionDockerService.sh"

            cyanprint "Provisioning LXC container..."
            bash "/opt/Wolflith/PCSRustMenu/src/Functions/Proxmox/Scripts/provisionLxc.sh"

            # Check appdata_location and run revised proxmox-lxc-cifs-share.sh script
            appdata_location=$(grep "appdata_location" /opt/Wolflith/Temp/provisioning_docker_service_vars.yml | cut -d '"' -f 2)
            if [[ "$appdata_location" == /mnt* ]]; then
                bash "/opt/Wolflith/PCSRustMenu/src/Functions/Proxmox/Scripts/proxmoxLxcCifsShare.sh"
            fi

            cyanprint "Executing Playbook... (Please be patient, may take more than 10 minutes to complete)"
            # Execute the Ansible playbook for the specified target(s), capturing output
            if ! output=$(ansible-playbook /opt/Wolflith/Ansible/playbooks/provision-proxmox-lxc.yml -i "/opt/Wolflith/Ansible/inventory/hosts.yaml" -l "$ansible_playbook_targets" 2>&1); then
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
            provision_docker_services_on_lxc
        fi
    done
}

provision_docker_services_on_lxc
