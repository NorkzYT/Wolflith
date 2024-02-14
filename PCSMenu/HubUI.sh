#!/bin/bash

# This will import the functions defined in the specified bash files into the current script.
source Functions/MainFunctions.sh
source Functions/PersonalizationFunctions.sh
source Functions/LinuxFunctions.sh
source Functions/ToolFunctions.sh
source Functions/ProxmoxFunction.sh
source Functions/DockerFunctions.sh
source Functions/KubernetesFunctions.sh
source Functions/AnsibleFunctions.sh
source Functions/GitHubFunctions.sh
source Functions/GitLabFunctions.sh
source Functions/MachineFunctions.sh

# Global variable to track the current menu context
CURRENT_MENU=""

#####################################################################################################################################################################

### HUB UI SECTION ###

#####################################################################################################################################################################

### Tools Sub_menu ###

server_name=$(hostname)

tools() {
    CURRENT_MENU="Tools"
    menu_cover    # Declared Menu_Cover
    menu_bar      # Declared Menu_Bar
    tools_options # Shows Tools Options
    go_back_menu  # Line to go back to main menu
    exit_script   # Line to exit script for all menus
    move_cursor   # Moves cursor
    input_color   # Changes input highlight color

    read a
    case $a in

    1)
        Color_Off
        sleep 0.2
        clear
        machine
        clear
        tools
        ;;

    #2)  ; tools ;;
    #3)  ; tools ;;
    #4)  ; tools ;;
    #5)  ; tools ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        tools
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

### Gitlab Sub_menu ###

gitlab() {
    CURRENT_MENU="GitLab"
    menu_cover     # Declared Menu_Cover
    menu_bar       # Declared Menu_Bar
    gitlab_options # Shows Kubernetes Options
    go_back_menu   # Line to go back to main menu
    exit_script    # Line to exit script for all menus
    move_cursor    # Moves cursor
    input_color    # Changes input highlight color

    read -r ans
    case $ans in
    1)
        Color_Off
        sleep 0.2
        clear
        gitlab_banner
        gitlab_cheat_sheets
        clear
        gitlab
        ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        gitlab
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

### Github Sub_menu ###

github() {
    CURRENT_MENU="GitHub"
    menu_cover     # Declared Menu_Cover
    menu_bar       # Declared Menu_Bar
    github_options # Shows Kubernetes Options
    go_back_menu   # Line to go back to main menu
    exit_script    # Line to exit script for all menus
    move_cursor    # Moves cursor
    input_color    # Changes input highlight color

    read -r ans
    case $ans in
    1)
        Color_Off
        sleep 0.2
        clear
        github_banner
        git_cheat_sheet
        clear
        github
        ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        github
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

### Ansible Sub_menu ###

ansible() {
    CURRENT_MENU="Ansible"
    menu_cover      # Declared Menu_Cover
    menu_bar        # Declared Menu_Bar
    ansible_message # Declared ansible_message
    ansible_options # Shows Tools Options
    go_back_menu    # Line to go back to main menu
    exit_script     # Line to exit script for all menus
    move_cursor     # Moves cursor
    input_color     # Changes input highlight color

    read a
    case $a in

    1)
        Color_Off
        sleep 0.2
        clear
        ansible_banner
        setup_hosts_add_machines
        clear
        ansible
        ;;

    2)
        Color_Off
        sleep 0.2
        clear
        ansible_banner
        new_machine_setup
        clear
        ansible
        ;;

    #2)  ; tools ;;
    #3)  ; tools ;;
    #4)  ; tools ;;
    #5)  ; tools ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        ansible
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

### Docker Sub_menu ###

docker() {
    CURRENT_MENU="Docker"
    menu_cover     # Declared Menu_Cover
    menu_bar       # Declared Menu_Bar
    docker_options # Shows Docker Options
    go_back_menu   # Line to go back to main menu
    exit_script    # Line to exit script for all menus
    move_cursor    # Moves cursor
    input_color    # Changes input highlight color

    read -r ans
    case $ans in
    1)
        Color_Off
        sleep 0.2
        clear
        docker_banner
        docker_install
        clear
        docker
        ;;

    2)
        Color_Off
        sleep 0.2
        clear
        docker_banner
        docker_update
        clear
        docker
        ;;

    3)
        Color_Off
        sleep 0.2
        clear
        docker_banner
        provision_docker_compose_service
        clear
        docker
        ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        docker
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

### Proxmox Sub_menu ###

proxmox() {
    CURRENT_MENU="Proxmox"
    menu_cover      # Declared Menu_Cover
    menu_bar        # Declared Menu_Bar
    proxmox_options # Shows Proxmox Options
    go_back_menu    # Line to go back to main menu
    exit_script     # Line to exit script for all menus
    move_cursor     # Moves cursor
    input_color     # Changes input highlight color

    read -r ans
    case $ans in
    1)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        provision_docker_services_on_lxc
        clear
        proxmox
        ;;

    2)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        pvesubscription_get
        clear
        proxmox
        ;;

    3)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        vzdump
        clear
        proxmox
        ;;

    4)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        pvecm_restart
        clear
        proxmox
        ;;

    5)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        pve_version
        clear
        proxmox
        ;;

    6)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        get_next_vm_id
        clear
        proxmox
        ;;

    7)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        sum_memory_allocated
        clear
        proxmox
        ;;

    8)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        sorted_list_vms
        clear
        proxmox
        ;;

    9)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        sorted_list_vm_ids
        clear
        proxmox
        ;;

    10)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        qm_list
        clear
        proxmox
        ;;

    11)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        qm_config
        clear
        proxmox
        ;;
    12)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        qm_unlock
        clear
        proxmox
        ;;
    13)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        qm_restore
        clear
        proxmox
        ;;
    14)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        vzrestore
        clear
        proxmox
        ;;
    15)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        lxc_start
        clear
        proxmox
        ;;
    16)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        mount_lxc_disk
        clear
        proxmox
        ;;
    17)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        unmount_lxc_disk
        clear
        proxmox
        ;;
    18)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        repair_lxc_disk
        clear
        proxmox
        ;;
    19)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        check_lxc_config
        clear
        proxmox
        ;;
    20)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        destroy_lxc
        clear
        proxmox
        ;;
    21)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        restore_lxc
        clear
        proxmox
        ;;
    22)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        vzctl
        clear
        proxmox
        ;;
    23)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        pvectl
        clear
        proxmox
        ;;
    24)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        vztop
        clear
        proxmox
        ;;
    25)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        display_user_beancounters
        clear
        proxmox
        ;;
    26)
        Color_Off
        sleep 0.2
        clear
        proxmox_banner
        vzlist
        clear
        proxmox
        ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        proxmox
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

### Linux Sub_menu ###

linux() {
    CURRENT_MENU="Linux"
    menu_cover    # Declared Menu_Cover
    menu_bar      # Declared Menu_Bar
    linux_options # Shows Linux Options
    go_back_menu  # Line to go back to main menu
    exit_script   # Line to exit script for all menus
    move_cursor   # Moves cursor
    input_color   # Changes input highlight color

    read -r ans
    case $ans in

    1)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        list_directory
        done_viewing
        clear
        linux
        ;;

    2)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        print_working_directory
        clear
        linux
        ;;

    3)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        change_directory
        clear
        linux
        ;;

    4)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        make_directory
        clear
        linux
        ;;
    5)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        move_file
        clear
        linux
        ;;
    6)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        copy_file
        clear
        linux
        ;;
    7)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        delete_file
        clear
        linux
        ;;

    8)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        create_file
        clear
        linux
        ;;
    9)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        create_link
        clear
        linux
        ;;
    10)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        display_file
        clear
        linux
        ;;
    11)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        clear_display
        clear
        linux
        ;;
    12)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        print_text
        clear
        linux
        ;;
    13)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        display_paged_output
        clear
        linux
        ;;
    14)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        access_manual_pages
        clear
        linux
        ;;
    15)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        get_os_info
        clear
        linux
        ;;
    16)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        get_username
        clear
        linux
        ;;
    17)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        compress_with_tar
        clear
        linux
        ;;
    18)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        search_string
        clear
        linux
        ;;

    19)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        display_lines_from_top
        clear
        linux
        ;;
    20)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        diff_files
        clear
        linux
        ;;
    21)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        cmp_files
        clear
        linux
        ;;
    22)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        comm
        clear
        linux
        ;;
    23)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        sort_file
        clear
        linux
        ;;
    24)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        export_env_var
        clear
        linux
        ;;
    25)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        zip
        clear
        linux
        ;;
    26)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        unzip_file
        clear
        linux
        ;;
    27)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        ssh_connect
        clear
        linux
        ;;
    28)

        Color_Off
        sleep 0.2
        clear
        linux_banner
        start_service
        clear
        linux
        ;;
    29)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        stop_service
        clear
        linux
        ;;
    30)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        display_processes
        clear
        linux
        ;;
    31)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        kill_by_id
        clear
        linux
        ;;
    32)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        killall_by_name
        clear
        linux
        ;;
    33)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        display_disk_info
        clear
        linux
        ;;
    34)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        mount_fs
        clear
        linux
        ;;
    35)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        chmod_ask
        clear
        linux
        ;;
    36)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        chown_prompt
        clear
        linux
        ;;
    37)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        show_ifconfig
        clear
        linux
        ;;
    38)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        traceroute
        clear
        linux
        ;;
    39)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        download_file
        clear
        linux
        ;;
    40)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        ufw_cmd
        clear
        linux
        ;;
    41)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        iptables_command
        clear
        linux
        ;;
    42)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        apt_package_manager
        clear
        linux
        ;;
    43)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        pacman_package_manager
        clear
        linux
        ;;
    44)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        yum_package_manager
        clear
        linux
        ;;
    45)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        rpm_package_manager
        clear
        linux
        ;;
    46)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        run_sudo
        clear
        linux
        ;;
    47)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        show_calendar
        clear
        linux
        ;;
    48)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        create_alias
        clear
        linux
        ;;
    49)
        Color_Off
        sleep 0.2
        dd_command
        clear
        linux
        ;;
    50)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        whereis_command
        clear
        linux
        ;;
    51)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        whatis
        clear
        linux
        ;;
    52)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        top
        clear
        linux
        ;;
    53)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        add_user
        clear
        linux
        ;;
    54)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        modify_user
        clear
        linux
        ;;

    55)
        Color_Off
        sleep 0.2
        clear
        linux_banner
        set_password
        clear
        linux
        ;;

    [xX]) exit_cmd ;;
    [bB])
        Color_Off
        main
        ;;
    *)
        Color_Off
        invalid_input
        linux
        ;;

    esac
    sleep 1
}

#####################################################################################################################################################################

### Main menu ###

main() {

    clear
    menu_cover       # Declared Menu_Cover
    menu_bar         # Declared Menu_Bar
    main_options     # Shows Main Options
    exit_script_main # Line to exit the script
    move_cursor      # Moves cursor
    input_color      # Changes input highlight color

    read -r ans
    case $ans in

    1)
        Color_Off
        sleep 0.1
        clear
        linux
        ;;
    2)
        Color_Off
        sleep 0.1
        clear
        proxmox
        ;;
    3)
        Color_Off
        sleep 0.1
        clear
        docker
        ;;

    4)
        Color_Off
        sleep 0.1
        clear
        ansible
        ;;

    5)
        Color_Off
        sleep 0.1
        clear
        github
        ;;

    6)
        Color_Off
        sleep 0.1
        clear
        gitlab
        ;;

    7)
        Color_Off
        sleep 0.1
        clear
        tools
        ;;

    [xX]) exit_cmd ;;
    *)
        Color_Off
        invalid_input
        main
        ;;

    esac
    sleep 1

}

#####################################################################################################################################################################
