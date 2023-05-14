#!/bin/bash

# PCSMenu ProxmoxFunctions.sh

#####################################################################################################################################################################

### Proxmox Functions ###

#####################################################################################################################################################################

function proxmox_banner {
    # Display a banner with the text "Proxmox"
    cat <<"EOF"

  ____                                    
 |  _ \ _ __ _____  ___ __ ___   _____  __
 | |_) | '__/ _ \ \/ / '_ ` _ \ / _ \ \/ /
 |  __/| | | (_) >  <| | | | | | (_) >  < 
 |_|   |_|  \___/_/\_\_| |_| |_|\___/_/\_\
                                          
        
EOF

    printf "\n"
}

### Proxmox Options ###

function proxmox_options() {
    printf "$Cyan"
    printf "1) A. pveperf                      2) B. pvesubscription_get      3) C. vzdump"
    printf "\n"
    printf "4) D. pvecm_restart                5) E. pveversion               6) F. get_next_vm_id"
    printf "\n"
    printf "7) G. sum_memory_allocated         8) H. sorted_list_vms          9) I. sorted_list_vm_ids"
    printf "\n"
    printf "10) J. qm_list                     11) K. qm_config               12) L. qm_unlock"
    printf "\n"
    printf "13) M. qmrestore                   14) N. vzrestore               15) O. lxc_start"
    printf "\n"
    printf "16) P. mount_lxc_disk              17) Q. unmount_lxc_disk        18) R. repair_lxc_disk"
    printf "\n"
    printf "19) S. check_lxc_config            20) T. destroy_lxc             21) U. restore_lxc"
    printf "\n"
    printf "22) V. vzctl                       23) W. pvectl                  24) X. vztop"
    printf "\n"
    printf "25) Y. display_user_beancounters   26) Z. zlist"
    printf "\n"
    printf "$Color_Off"
    echo ""
}

# --------------------------------------------------------------- #

####################################################

### 1 ###

####################################################

function pveperf() {

    printf "The pveperf command is a command-line tool for monitoring and analyzing the performance of a Proxmox VE cluster. It displays various performance metrics, such as CPU usage, memory usage, and network usage, for all nodes in the cluster.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        pveperf
    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            pveperf
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            pveperf
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 2 ###

####################################################

function pvesubscription_get() {
    printf "The pvesubscription get command is a Proxmox VE command that retrieves the current subscription status of a Proxmox VE server. It displays information about the subscription, such as the subscription type, the expiration date, and the number of nodes covered by the subscription.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        pvesubscription get
    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            pvesubscription_get
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            pvesubscription_get
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

function vzdump() {
    printf "The script prompts the user to enter the ID of a machine and then runs the vzdump command with the ID of the machine and the -compress lzo option. The vzdump command creates backups of OpenVZ containers and the -compress lzo option specifies that the backups should be compressed using the LZO algorithm.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        read -p "Enter the ID of the machine to back up: " machine_id
        vzdump $machine_id -compress lzo
    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            vzdump
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            vzdump
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 4 ###

####################################################

function pvecm_restart() {

    printf "The command restarts the pve-cluster, pvedaemon, pvestatd, and pveproxy services. Services are programs that run in the background and perform tasks on a computer. Restarting a service means stopping the service, if it is currently running, and starting it again.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        service pve-cluster restart && service pvedaemon restart && service pvestatd restart && service pveproxy restart

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            pvecm_restart
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            pvecm_restart
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 5 ###

####################################################

function pve_version() {
    printf "The pveversion command is a Proxmox VE command that displays the version of Proxmox VE that is installed on the system.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        pveversion
    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            pveversion
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            pveversion
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 6 ###

####################################################

function get_next_vm_id() {
    printf "The pvesh get /cluster/nextid command retrieves the next available ID in the cluster using the Proxmox VE API. The pvesh command is a Proxmox VE command that allows you to access and manipulate the Proxmox VE API from the command line, and the get subcommand retrieves information from the API. The /cluster/nextid parameter specifies that the command should retrieve the next available ID in the cluster.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        pvesh get /cluster/nextid
    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            get_next_vm_id
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            get_next_vm_id
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 7 ###

####################################################

function sum_memory_allocated() {
    printf "The command searches the /etc/pve/local directory for the string 'memory' using the grep command, pipes the output to the awk command, and then prints the sum of the last field of each line. The grep command searches for lines that contain a specified pattern in a file or group of files, and the awk command is a programming language that processes and analyzes text files. The awk command in this script calculates the sum of the last field of each line and prints the result.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        grep -R memory /etc/pve/local | awk '{sum += $NF } END {print sum;}'

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            sum_memory_allocated
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            sum_memory_allocated
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 8 ###

####################################################

function sorted_list_vms() {
    printf "The command reads the file /etc/pve/.vmlist, searches for lines that contain the string 'node' using the grep command, removes the characters '\":,' from each line using the tr command, formats the output using the awk command, sorts the output numerically using the sort command, and formats the output into columns using the column command. The cat command reads the contents of a file and prints them to the terminal, the grep command searches for lines that contain a specified pattern in a file or group of files, the tr command translates or deletes characters in a string, the awk command is a programming language that processes and analyzes text files, the sort command sorts the lines of text in a file or standard input, and the column command formats the output into columns.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        cat /etc/pve/.vmlist | grep node | tr -d '":,' | awk '{print $1" "$4" "$6 }' | sort -n | column -t

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            sorted_list_vms
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            sorted_list_vms
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 9 ###

####################################################

function sorted_list_vm_ids() {
    printf "The command reads the file /etc/pve/.vmlist, searches for lines that contain the string 'node' using the grep command, extracts the second field using the cut command, and sorts the output numerically using the sort command. The cat command reads the contents of a file and prints them to the terminal, the grep command searches for lines that contain a specified pattern in a file or group of files, and the cut command extracts selected fields from a file or standard input. The sort command sorts the lines of text in a file or standard input.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        cat /etc/pve/.vmlist | grep node | cut -d '"' -f2 | sort -n

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            sorted_list_vm_ids
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            sorted_list_vm_ids
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 10 ###

####################################################

function qm_list() {
    printf "The qm list command is a Proxmox VE command that displays a list of all virtual machines on the system.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # List all your KVM machines.
        qm list

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            qm_list
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            qm_list
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 11 ###

####################################################

function qm_config() {
    printf "The command prompts the user to enter a machine number, retrieves the configuration of the specified machine using the qm config command, and searches for lines that begin with 'memory' using the grep command. The read command reads a line of input from the terminal and stores it in a variable, the qm config command is a Proxmox VE command that displays the configuration of a virtual machine, and the grep command searches for lines that contain a specified pattern in a file or group of files.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # See how much memory your machine has.
        read -p "Enter the machine number: " machine_num
        qm config $machine_num | grep ^memory

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            qm_config
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            qm_config
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 12 ###

####################################################

function qm_unlock() {
    printf "The command prompts the user to enter a machine number and unlocks the specified machine using the qm unlock command. The read command reads a line of input from the terminal and stores it in a variable, and the qm unlock command is a Proxmox VE command that unlocks a virtual machine.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Unlock a KVM machine.
        read -p "Enter the machine number: " machine_num
        qm unlock $machine_num

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            qm_unlock
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            qm_unlock
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 13 ###

####################################################

function qm_restore() {
    printf "The command prompts the user to enter the file path of a backup and the machine number to restore to, and restores the virtual machine to the specified machine number using the qmrestore command. The read command reads a line of input from the terminal and stores it in a variable, and the qmrestore command is a Proxmox VE command that restores a virtual machine from a backup file.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Restore a QemuServer VM to a specified machine number.
        read -p "Enter the file path of the backup: " file_path
        read -p "Enter the machine number to restore to: " machine_num
        qmrestore $file_path $machine_num

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            qmrestore
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            qmrestore
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 14 ###

####################################################

function vzrestore() {
    printf "The vzrestore command is a Proxmox VE command that restores a container from a backup file.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Restore OpenVZ vzdump backups.
        vzrestore

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            vzrestore
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            vzrestore
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 15 ###

####################################################

function lxc_start() {
    printf "The command prompts the user to enter the ID of a machine, and starts the specified machine using the lxc-start command with the -n and -F options. The read command reads a line of input from the terminal and stores it in a variable, and the lxc-start command starts a container. The -n option specifies the name of the container to start, and the -F option causes the container to start in the foreground.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        read -p "Enter the ID of the machine to start: " machine_id
        lxc-start -n $machine_id -F

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            lxc_start
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            lxc_start
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 16 ###

####################################################

function mount_lxc_disk() {
    printf "The command prompts the user to enter the ID of a machine, and mounts the root filesystem of the specified machine using the pct mount command. The read command reads a line of input from the terminal and stores it in a variable, and the pct mount command is a Proxmox VE command that mounts the root filesystem of a container.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        read -p "Enter the ID of the machine: " machine_id
        pct mount $machine_id

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            mount_lxc_disk
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            mount_lxc_disk
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 17 ###

####################################################

function unmount_lxc_disk() {
    printf "The command prompts the user to enter the ID of a machine, and unmounts the root filesystem of the specified machine using the pct unmount command. The read command reads a line of input from the terminal and stores it in a variable, and the pct unmount command is a Proxmox VE command that unmounts the root filesystem of a container.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        read -p "Enter the ID of the machine: " machine_id
        pct unmount $machine_id

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            unmount_lxc_disk
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            unmount_lxc_disk
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 18 ###

####################################################

function repair_lxc_disk() {
    printf "The command prompts the user to enter the ID of a machine, and checks the file system of the specified machine using the pct fsck command. The read command reads a line of input from the terminal and stores it in a variable, and the pct fsck command is a Proxmox VE command that checks the file system of a container.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        read -p "Enter the ID of the machine: " machine_id
        pct fsck $machine_id

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            repair_lxc_disk
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            repair_lxc_disk
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 19 ###

####################################################

function check_lxc_config() {
    printf "The command prompts the user to enter the ID of a machine, and displays the configuration of the specified machine using the pct config command. The read command reads a line of input from the terminal and stores it in a variable, and the pct config command is a Proxmox VE command that displays the configuration of a container.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        read -p "Enter the ID of the machine: " machine_id
        pct config $machine_id

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            check_lxc_config
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            check_lxc_config
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 20 ###

####################################################

function destroy_lxc() {
    printf "The command prompts the user to enter the ID of a machine, and destroys the specified machine using the pct destroy command. The read command reads a line of input from the terminal and stores it in a variable, and the pct destroy command is a Proxmox VE command that destroys a container.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        read -p "Enter the ID of the machine: " machine_id
        pct destroy $machine_id

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            destroy_lxc
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            destroy_lxc
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 21 ###

####################################################

function restore_lxc() {
    printf "The command prompts the user to enter the ID of a new container and the path to a backup file, and restores the specified backup file to the new container using the pct restore command. The read command reads a line of input from the terminal and stores it in a variable, and the pct restore command is a Proxmox VE command that restores a backup file to a container.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        read -p "Enter the ID of the new container: " new_id
        read -p "Enter the path to the backup file: " file_path
        pct restore $new_id $file_path

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            restore_lxc
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            restore_lxc
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 22 ###

####################################################

function vzctl() {
    printf "The command is a utility to control an OpenVZ container. The vzctl command is a utility to control an OpenVZ container, and allows you to start, stop, and manage containers on a Proxmox VE server.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Utility to control an OpenVZ container.
        vzctl

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            vzctl
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            vzctl
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 23 ###

####################################################

function pvectl() {
    printf "The command is a wrapper to manage OpenVZ containers using the vzctl utility. The pvectl command is a wrapper for the vzctl utility, which is a utility to control an OpenVZ container, and allows you to start, stop, and manage containers on a Proxmox VE server.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Vzctl wrapper to manage OpenVZ containers.
        pvectl

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            pvectl
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            pvectl
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 24 ###

####################################################

function vztop() {
    printf "The command displays the top CPU processes running in an OpenVZ container. The vztop command is a utility to display the top CPU processes running in an OpenVZ container, and allows you to see which processes are using the most CPU resources on a Proxmox VE server.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        # Display top CPU processes.
        vztop

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            vztop
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            vztop
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 25 ###

####################################################

function display_user_beancounters() {
    printf "The command displays the resource usage limits and current usage levels for an OpenVZ container. The cat /proc/user_beancounters command is used to display the resource usage limits and current usage levels for an OpenVZ container, and allows you to see the current resource usage of a container and its limits on a Proxmox VE server.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        cat /proc/user_beancounters

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            display_user_beancounters
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            display_user_beancounters
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 26 ###

####################################################

function vzlist() {
    printf "The command lists the running OpenVZ containers on a Proxmox VE server. The vzlist command is used to list the running OpenVZ containers on a Proxmox VE server, and allows you to see the container IDs, names, and status of all running containers on the server.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then
        vzlist

    else

        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi
    printf "\n--------------------------------------------------------------------------------\n"

    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        proxmox

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            proxmox_banner
            vzlist
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            proxmox_banner
            vzlist
        fi
    fi
}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
