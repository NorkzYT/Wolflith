#!/bin/bash

# PCSMenu LinuxFunctions.sh

#####################################################################################################################################################################

### Linux Functions ###

#####################################################################################################################################################################

function linux_banner {
    # Display a banner with the text "Linux"
    printf "$Red"
    cat <<"EOF"
  _ _                  
 | (_)_ __  _   ___  __
 | | | '_ \| | | \ \/ /
 | | | | | | |_| |>  < 
 |_|_|_| |_|\__,_/_/\_\
        
EOF
    printf "$Color_Off"
    printf "\n"
}

##### Linux Menu Options #####
function linux_options() {

    printf "$Cyan"
    printf "1) A. List Directory                2) B. Print Working Directory      3) C. Change Directory"
    printf "\n"
    printf "4) D. Make Directory                5) E. Move File                    6) F. Copy File"
    printf "\n"
    printf "7) G. Delete File                   8) H. Create File                  9) I. Create Link"
    printf "\n"
    printf "10) J. Display File                 11) K. Clear Display               12) L. Print Text"
    printf "\n"
    printf "13) M. Display Paged Output         14) N. Access Manual Pages         15) O. Get OS Information"
    printf "\n"
    printf "16) P. Get Active Username          17) Q. Compress with TAR           18) R. Search String"
    printf "\n"
    printf "19) S. Display Lines from Top       20) Difference in files            21) T. Compare Files"
    printf "\n"
    printf "22) U. COMM                         23) V. Sort File                   24) W. Export Environment Variable "
    printf "\n"
    printf "25) X. ZIP                          26) Y. Unzip                       27) Z. Secure Shell (SSH)"
    printf "\n"
    printf "28) AA. Start Service               29) AB. Stop Service               30) AC. Display Processes"
    printf "\n"
    printf "31) AD. Kill by ID                  32) AE. Killall by Name            33) AF. Display Disk Info"
    printf "\n"
    printf "34) AG. Mount File System           35) AH. Change File Permissions    36) AI. Grant Ownership"
    printf "\n"
    printf "37) AJ. Show Network Interfaces     38) AK. Trace Network Hops         39) AL. Download File"
    printf "\n"
    printf "40) AM. Firewall Command            41) AN. Base Firewall              42) AO. Package Manager (APT)"
    printf "\n"
    printf "43) AP. Package Manager (Pacman)    44) AQ. Package Manager (YUM)      45) AR. Package Manager (RPM)"
    printf "\n"
    printf "46) AS. Run Sudo                    47) AT. Show Calender              48) AU. Create Alias"
    printf "\n"
    printf "49) AV. DD Command                  50) AW. Locate Binary              51) AX. Whatis Command"
    printf "\n"
    printf "52) AY. View Active Processes       53) AZ. Add User                   54) BA. Modify User"
    printf "\n"
    printf "55) BB. Set Password"

    printf "$Color_Off"
    echo ""

}

# --------------------------------------------------------------- #

####################################################

### 1 ###

####################################################

function list_directory() {
    printf "The command lists the files and directories in a specified directory. The ls \"$directory\" command is used to list the files and directories in a specified directory, and allows you to see the contents of a directory on a Unix-like system.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the directory to list.
        read -p "Enter directory: " directory
        printf "\n--------------------------------------------------------------------------------\n"
        # Run the "ls" command on the specified directory.
        ls "$directory"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            list_directory
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            list_directory
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 2 ###

####################################################

function print_working_directory() {

    printf "The command prompts the user for a directory and then prints the specified or current working directory. The read -p \"Enter a directory (or leave blank for the current directory): \" directory command prompts the user for a directory, and the if [ -z \"$directory\" ]; then directory=$(pwd) statement checks if the user entered a directory or not. If the user did not enter a directory, the current working directory is used. The echo \"Directory: $directory\" command prints the specified or current working directory.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for a directory, or use the current working directory if not provided.
        read -p "Enter a directory (or leave blank for the current directory): " directory
        if [ -z "$directory" ]; then
            directory=$(pwd)
        fi

        printf "\n--------------------------------------------------------------------------------\n"
        # Print the specified or current working directory.
        echo "Directory: $directory"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            print_working_directory

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            print_working_directory
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 3 ###

####################################################

function change_directory() {
    printf "The command prompts the user for a directory and then changes to the specified directory. The read -p \"Enter directory: \" directory command prompts the user for a directory, and the cd \"$directory\" command changes to the specified directory.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the directory to change to.
        read -p "Enter directory: " directory

        # Change to the specified directory.
        cd "$directory"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            change_directory
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            change_directory
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 4 ###

####################################################

function make_directory() {
    printf "The command prompts the user for the name of a new directory and then creates the new directory. The read -p \"Enter directory name: \" directory_name command prompts the user for the name of a new directory, and the mkdir \"$directory_name\" command creates the new directory.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command
    echo ""

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the name of the new directory.
        read -p "Enter directory name: " directory_name

        # Create the new directory.
        mkdir "$directory_name"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            make_directory
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            make_directory
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 5 ###

####################################################

function move_file() {
    printf "The command prompts the user for the name of a file and the destination for the file, and then moves or renames the file to the specified destination. The read -p \"Enter file name: \" file_name command prompts the user for the name of the file to be moved or renamed, and the read -p \"Enter destination: \" destination command prompts the user for the destination for the file. The mv \"$file_name\" \"$destination\" command moves or renames the file to the specified destination.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the name of the file to be moved or renamed.
        read -p "Enter file name: " file_name
        printf "\n--------------------------------------------------------------------------------\n"

        # Ask the user for the destination for the file.
        read -p "Enter destination: " destination

        # Move or rename the file.
        mv "$file_name" "$destination"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            move_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            move_file
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 6 ###

####################################################

function copy_file() {
    printf "Prompts the user for the name of a file and the destination for the copied file. It then copies the file to the specified destination.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the name of the file to be copied.
        read -p "Enter file name: " file_name
        printf "\n--------------------------------------------------------------------------------\n"

        # Ask the user for the destination for the copied file.
        read -p "Enter destination: " destination

        # Copy the file.
        cp "$file_name" "$destination"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            copy_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            copy_file
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 7 ###

####################################################

function delete_file() {
    printf "This code prompts the user to enter the name of a file or directory, which is stored in the variable file_name. It then prints a line of hyphens as a separator. Finally, it deletes the file or directory specified by file_name, including any files and directories contained within it (the -r option stands for "$(recursive)"). Note that this operation cannot be undone, so use caution when running this command.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the name of the file or directory to be deleted.
        read -p "Enter file or directory name: " file_name
        printf "\n--------------------------------------------------------------------------------\n"
        # Delete the file or directory.
        rm -r "$file_name"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            delete_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            delete_file
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 8 ###

####################################################

function create_file() {
    printf "This code prompts the user to enter the name of a file, which is stored in the variable file_name. It then prints a line of hyphens as a separator. Finally, it creates a new file with the name specified by file_name.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the name of the file to be created.
        read -p "Enter file name: " file_name
        printf "\n--------------------------------------------------------------------------------\n"
        # Create the file.
        touch "$file_name"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            create_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            create_file
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 9 ###

####################################################

function create_link() {
    printf "This code prompts the user to enter the name of a file and a symbolic link, which are stored in the variables file_name and link_name, respectively. It then prints a line of hyphens as a separator. Finally, it creates a new symbolic link with the name specified by link_name, which points to the file specified by file_name.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the name of the file to be linked.
        read -p "Enter file name: " file_name

        # Ask the user for the name of the link.
        read -p "Enter link name: " link_name
        printf "\n--------------------------------------------------------------------------------\n"
        # Create the symbolic link.
        ln -s "$file_name" "$link_name"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            create_link
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            create_link
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 10 ###

####################################################

function display_file() {
    printf "This code prompts the user to enter the name of a file, which is stored in the variable file_name. It then prints a line of hyphens as a separator. Finally, it displays the contents of the file specified by file_name.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the name of the file to be displayed.
        read -p "Enter file name: " file_name
        printf "\n--------------------------------------------------------------------------------\n"
        # Display the contents of the file.
        cat "$file_name"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            display_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            display_file
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 11 ###

####################################################

function clear_display() {
    printf "This code clears the terminal display.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Clear the terminal display.
        clear

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            clear_display
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            clear_display
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 12 ###

####################################################

function print_text() {
    printf "This code prompts the user to enter some text, which is stored in the variable text.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the text to be printed.
        read -p "Enter text to print: " text

    else
        printf "\n--------------------------------------------------------------------------------\n"
        printf "\nThe command was not run.\n"
    fi

    printf "\n--------------------------------------------------------------------------------\n"
    # Print the text to the terminal.
    echo "$text"
    printf "\n--------------------------------------------------------------------------------\n"
    # Done viewing function
    # Ask the user if they are done viewing the current option
    read -p "Are you done viewing this option? (yes/no) " done

    # Check the user's answer
    if [[ "$done" == "yes" ]] || [[ "$done" == "y" ]] || [[ "$done" == "Yes" ]] || [[ "$done" == "Y" ]]; then
        # Return to the main menu
        clear
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            print_text
        else

            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            print_text
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 13 ###

####################################################

function display_paged_output() {
    printf "This code prompts the user to enter the name of a file, which is stored in the variable file. It then prints a line of hyphens as a separator. Finally, it displays the contents of the file specified by file in the terminal using the less command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the file to be displayed.
        read -p "Enter the file to display: " file
        printf "\n--------------------------------------------------------------------------------\n"
        # Display the contents of the file in the terminal using the "less" command.
        less "$file"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            display_paged_output
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            display_paged_output
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 14 ###

####################################################

function access_manual_pages() {
    printf "This code prompts the user to enter a command, which is stored in the variable command. It then prints a line of hyphens as a separator. Finally, it displays the manual page for the command specified by command using the man command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the command to display the manual page for.
        read -p "Enter the command to display the manual page for: " command
        printf "\n--------------------------------------------------------------------------------\n"
        # Display the manual page for the specified command using the "man" command.
        man "$command"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            access_manual_pages
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            access_manual_pages
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 15 ###

####################################################

function get_os_info() {
    printf "This code displays basic information about the operating system using the uname command. The -a option is used to show all available information.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Display basic information about the operating system using the "uname" command.
        uname -a

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
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            get_os_info
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            get_os_info
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 16 ###

####################################################

function get_username() {
    printf "This code prompts the user to enter a username, which is stored in the variable username. It then prints a line of hyphens as a separator. Finally, it displays the active username using the whoami command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        read -p "Enter your username: " username
        # Display the active username using the "whoami" command.
        printf "\n--------------------------------------------------------------------------------\n"
        whoami $username

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            get_username
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            get_username

        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 17 ###

####################################################

function compress_with_tar() {
    printf "This code prompts the user to enter the names of an input file or directory and an output file, which are stored in the variables input_file and output_file, respectively. It then prints a line of hyphens as a separator. Finally, it compresses the input file or directory using the tar command, with the -c and -z options to create a gzip archive and the -f option to specify the output file, and stores the resulting compressed file in the output file specified by output_file.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        read -p "Enter the name of the file or directory you want to compress: " input_file
        read -p "Enter the name of the output file: " output_file
        printf "\n--------------------------------------------------------------------------------\n"
        tar -czf $output_file $input_file

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            compress_with_tar
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            compress_with_tar
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 18 ###

####################################################

function search_string() {
    printf "This code prompts the user to enter a string to search for and an output file to search in, which are stored in the variables string and output, respectively. It then prints a line of hyphens as a separator. Finally, it searches for the string specified by string within the output file specified by output using the grep command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for a string to search for.
        read -p "Enter the string to search for: " string

        # Prompt the user for an output to search in.
        read -p "Enter the output to search in: " outputa
        printf "\n--------------------------------------------------------------------------------\n"
        # Run the grep command to search for the string within the output.
        grep "$string" "$output"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            search_string
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            search_string
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 19 ###

####################################################

function display_lines_from_top() {
    printf "This code prompts the user to enter a number of lines to display and a file to display the lines from, which are stored in the variables num_lines and file, respectively. It then prints a line of hyphens as a separator. Finally, it displays the specified number of lines from the top of the file specified by file using the head command with the -n option to specify the number of lines.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the number of lines to display.
        read -p "Enter the number of lines to display: " num_lines

        # Prompt the user for the file to display the lines from.
        read -p "Enter the file to display the lines from: " file
        printf "\n--------------------------------------------------------------------------------\n"
        # Use the head command to display the specified number of lines from the top of the file.
        head -n "$num_lines" "$file"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            display_lines_from_top
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            display_lines_from_top
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 20 ###

####################################################

function diff_files() {
    printf "This code prompts the user to enter the directory and names of two files, which are stored in the variables directory, file1, and file2, respectively. It then prints a line of hyphens as a separator. Finally, it compares the two files specified by directory/file1 and directory/file2 using the diff command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the directory and names of the two files to compare.
        read -p "Enter the directory of the files: " directory
        read -p "Enter the name of the first file: " file1
        read -p "Enter the name of the second file: " file2
        printf "\n--------------------------------------------------------------------------------\n"
        # Use the "diff" command to compare the two files.
        diff "$directory/$file1" "$directory/$file2"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            diff_files
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            diff_files
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 21 ###

####################################################

# Function to compare two files
function cmp_files() {
    printf "This code prompts the user to enter the directory and names of two files, which are stored in the variables directory, file1, and file2, respectively. It then checks if the specified files exist. If one or both of the files do not exist, an error message is displayed. If the files do exist, the script compares the two files using the cmp command. If the files are identical, a message is displayed to that effect; otherwise, a message is displayed indicating that the files are not identical.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the directory and names of the two files to compare.
        read -p "Enter the directory of the files: " directory
        read -p "Enter the name of the first file: " file1
        read -p "Enter the name of the second file: " file2
        # Check if the files exist
        if [ ! -f "$directory/$file1" ] || [ ! -f "$directory/$file2" ]; then
            echo "Error: One or both of the specified files does not exist."
            return
        fi

        # Compare the files
        cmp "$directory/$file1" "$directory/$file2"

        # Check the exit status of the cmp command
        if [ "$?" -eq 0 ]; then
            echo "The files are identical."
        else
            echo "The files are not identical."
        fi

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
        linux
    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            cmp_files
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            cmp_files
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 22 ###

####################################################

function comm() {
    printf "This code checks if there are exactly two arguments provided. If not, it displays an error message and exits. It then checks if the two specified files exist. If one or both of the files do not exist, it displays an error message and exits. If the checks pass, it runs the comm command with the specified arguments.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Check if there are exactly two arguments
        if [[ $# -ne 2 ]]; then
            echo "Error: comm command requires exactly two files as arguments"
            return 1
        fi

        # Check if the two files exist
        if [[ ! -f $1 || ! -f $2 ]]; then
            echo "Error: one or both of the specified files do not exist"
            return 1
        fi

        # Run the comm command with the specified arguments
        command comm $1 $2

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            comm
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            comm
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 23 ###

####################################################

function sort_file() {
    printf "This code checks if a file name was passed as an argument. If not, it displays an error message and exits. If a file name was provided, it sorts the contents of the file and saves the output to a new file with the same name and a .sorted extension. It then displays a message to confirm that the file was sorted.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Check if a file name was passed as an argument
        if [ -z "$1" ]; then
            # If no file name was passed, print an error message and exit
            echo "Error: No file name was provided"
            return 1
        fi

        # Sort the content of the file and save the output to a new file
        sort "$1" >"$1.sorted"
        # Print a message to confirm that the file was sorted
        echo "Successfully sorted the content of the file: $1"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            sort_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            sort_file
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 24 ###

####################################################

function export_env_var() {
    printf "This code prompts the user to enter the name and value of an environment variable, which are stored in the variables env_var_name and env_var_value, respectively. It then exports the environment variable with the specified name and value.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the name of the environment variable to be exported
        read -p "Enter the name of the environment variable: " env_var_name
        # Prompt the user for the value of the environment variable to be exported
        read -p "Enter the value of the environment variable: " env_var_value
        # Export the environment variable
        export "$env_var_name=$env_var_value"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            export_env_var
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            export_env_var
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 25 ###

####################################################

function zip() {
    printf "This code checks if the zip command is installed, and if not, installs it. It then prompts the user to enter the name and path of a file or directory to be zipped, which are stored in the variables zip_name and zip_path, respectively. It then creates a zip file with the specified name and containing the specified file or directory using the zip command with the -r option to include subdirectories.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Check if the zip command is installed
        if ! [ -x "$(command -v zip)" ]; then
            # Install the zip command if it is not already installed
            sudo apt-get install zip
        fi

        # Get the name of the zip file from the user
        read -p "Enter the name of the zip file: " zip_name

        # Get the directory or file to be zipped from the user
        read -p "Enter the path of the directory or file to be zipped: " zip_path

        # Create the zip file using the user-specified name and path
        zip -r "$zip_name" "$zip_path"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            zip
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            zip
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 26 ###

####################################################

# Function to unzip a file
# Usage: unzip_file <filename>
function unzip_file {
    printf "This code prompts the user to enter the directory and name of a file to unzip, which are stored in the variables directory and file, respectively. It then checks if the file exists. If the file exists, it extracts the file using the unzip command. If the file does not exist, it displays an error message.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the directory and name of the file to unzip.
        read -p "Enter the directory of the file: " directory
        read -p "Enter the name of the file: " file

        # Check if the file exists
        if [ -f "$directory/$file" ]; then
            # Extract the file using the unzip command
            unzip "$directory/$file"
        else
            # Print an error message if the file does not exist
            echo "Error: File does not exist."
        fi

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            unzip_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            unzip_file
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 27 ###

####################################################

# Function to connect to a remote server via SSH
function ssh_connect() {
    printf "This code prompts the user to enter the IP address and username of a server, which are stored in the variables server_ip and username, respectively. It then connects to the server using the ssh command with the provided IP address and username.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt user for the server IP address
        read -p "Enter the IP address of the server: " server_ip

        # Prompt user for the username to use for the connection
        read -p "Enter the username for the server: " username

        # Connect to the server using the provided IP address and username
        ssh "$username@$server_ip"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            ssh_connect
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            ssh_connect
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 28 ###

####################################################

function start_service() {
    printf "This code prompts the user to enter the name of a service, which is stored in the variable service_name. It then starts the service using the service command with the start option. It then checks the status of the service after starting using the service command with the status option.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the service name
        read -p "Enter the name of the service to start: " service_name
        # Start the service
        sudo service $service_name start
        # Check the status of the service after starting
        sudo service $service_name status

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            start_service
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            start_service
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 29 ###

####################################################

function stop_service() {
    printf "This code prompts the user to enter the name of a service, which is stored in the variable service. It then checks if a service name was provided. If a service name was provided, it stops the service using the service command with the stop option, and then checks the status of the service after stopping using the service command with the status option. If no service name was provided, it displays an error message and exits.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the service name and directory
        read -p "Enter the name of the service: " service

        # Check if the user has provided a service name
        if [[ -z "$service" ]]; then
            echo "Error: No service name provided"
            return 1
        fi

        # Stop the service
        sudo service "$directory/$service" stop
        # Check the status of the service after stopping
        sudo service "$directory/$service" status

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            stop_service
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            stop_service
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 30 ###

####################################################

# Function to display active processes
function display_processes() {
    printf "This code uses the ps command with the -ef options to get a list of processes running on the system, and stores the output in the variable processes. It then echoes the processes variable to display the list of processes.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Get the process list
        processes=$(ps -ef)

        # Print the process list
        echo "$processes"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            display_processes
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            display_processes
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 31 ###

####################################################

# Function to kill a process by its ID
function kill_by_id() {
    printf "This code prompts the user to enter a process ID, which is stored in the variable process_id. It then uses the kill command to terminate the process with the specified ID.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user to enter the process ID
        read -p "Enter the process ID: " process_id

        # Kill the process with the given ID
        kill "$process_id"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            kill_by_id
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            kill_by_id
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 32 ###

####################################################'

# Function to kill all processes with a given name
function killall_by_name() {
    printf "This code prompts the user to enter a process name, which is stored in the variable process_name. It then uses the killall command to terminate all processes with the specified name.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user to enter the process name
        read -p "Enter the process name: " process_name

        # Kill all processes with the given name
        killall "$process_name"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            killall_by_name
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            killall_by_name
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 33 ###

####################################################

function display_disk_info() {
    printf "This code prompts the user to enter a path or file system type, which is stored in the variable input. It then uses the df command to display the disk filesystem information based on the user's input.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for input
        read -p "Enter a path or file system type: " input

        # Display the disk filesystem information based on the user's input
        df "$input"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            display_disk_info
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            display_disk_info
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 34 ###

####################################################

function mount_fs() {
    printf "This code prompts the user to enter a file system and a mount point, which are stored in the variables fs and mount_point, respectively. It then uses the mount command to mount the file system at the specified mount point.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the file system and mount point
        read -p "Enter the file system to be mounted: " fs
        read -p "Enter the mount point: " mount_point

        # Mount the file system at the specified mount point
        mount "$fs" "$mount_point"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            mount_fs

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            mount_fs
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 35 ###

####################################################

function chmod_ask() {
    printf "This code prompts the user to enter a file path and a permission level, which are stored in the variables file_path and permission, respectively. It then uses the chmod command to change the permissions of the specified file to the specified level.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        read -p "Enter the file path: " file_path
        read -p "Enter the permission level (e.g. 755): " permission

        chmod "$permission" "$file_path"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            chmod_ask
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            chmod_ask
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 36 ###

####################################################

function chown_prompt() {
    printf "This code prompts the user to enter a file or folder path, a new owner, and a new group, which are stored in the variables path, owner, and group, respectively. It then uses the chown command to change the owner and group of the specified file or folder to the specified values.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt user for file or folder path
        read -p "Enter the file or folder path: " path

        # Prompt user for owner and group
        read -p "Enter the new owner: " owner
        read -p "Enter the new group: " group

        # Run chown command with specified path, owner, and group
        chown "$owner:$group" "$path"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            chown_prompt
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            chown_prompt
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 37 ###

####################################################

function show_ifconfig() {
    printf "This code prompts the user to enter an interface name, which is stored in the variable interface. It then uses the ifconfig command to display information about the specified interface, and pipes the output to the grep command, which searches for the string 'inet '. The output of the grep command is then piped to the awk command, which extracts the second field from the input and prints it.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        read -p "Enter the interface name: " interface
        ifconfig "$interface" | grep "inet " | awk '{print $2}'

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            show_ifconfig
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            show_ifconfig
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 38 ###

####################################################

function traceroute() {
    printf "This code prompts the user to enter a destination IP or hostname, which is stored in the variable destination. It then runs the traceroute command with the specified destination as an argument. The traceroute command is used to trace the route that packets take from the host to the specified destination.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the destination IP or hostname
        read -p "Enter the destination IP or hostname: " destination

        # Run the traceroute command and pass in the destination as an argument
        traceroute "$destination"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            traceroute
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            traceroute
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 39 ###

####################################################
function download_file() {
    printf "This code prompts the user to enter the URL of a file to download, which is stored in the variable file_url. It then downloads the file using the wget command with the specified URL.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the URL of the file to download
        read -p "Enter the URL of the file to download: " file_url

        # Download the file using wget
        wget $file_url

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            download_file
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            download_file
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 40 ###

####################################################

function ufw_cmd() {
    printf "This code prompts the user to enter an action (either 'enable', 'disable', or 'status'), and then performs the corresponding action using the 'ufw' command.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'action'. The '-p' flag specifies that the string 'Enter the action (enable, disable, or status): ' should be displayed as a prompt before reading the input.\n\nThe 'if', 'elif', and 'else' statements are used to specify different actions based on the value of the 'action' variable. If 'action' is equal to 'enable', the code enables the firewall using the 'ufw enable' command. If 'action' is equal to 'disable', the code disables the firewall using the 'ufw disable' command. If 'action' is equal to 'status', the code displays the status of the firewall using the 'ufw status' command. If 'action' is none of these, the code prints an error message.\n"
    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the desired action (enable, disable, or status)
        read -p "Enter the action (enable, disable, or status): " action

        # If the action is "enable"
        if [ "$action" == "enable" ]; then
            # Enable the firewall
            ufw enable
        # If the action is "disable"
        elif [ "$action" == "disable" ]; then
            # Disable the firewall
            ufw disable
        # If the action is "status"
        elif [ "$action" == "status" ]; then
            # Display the status of the firewall
            ufw status
        else
            # If the action is invalid, print an error message
            echo "Invalid action"
        fi

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            ufw_cmd
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            ufw_cmd
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 41 ###

####################################################

function iptables_command() {
    printf "This code prompts the user to enter an iptables command, and then runs the command as a superuser (using the 'sudo' command).\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'command'. The '-p' flag specifies that the string 'Enter the iptables command: ' should be displayed as a prompt before reading the input.\n\nThe 'sudo iptables \"$command\"' runs the 'iptables' command with the user-provided 'command' as an argument. The '\"$command\"' part is necessary to ensure that the value stored in the 'command' variable is treated as a single argument, even if it contains spaces or other special characters.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for an iptables command
        read -p "Enter the iptables command: " command

        # Run the iptables command
        sudo iptables "$command"

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            iptables_command

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            iptables_command
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 42 ###

####################################################

# Function for apt package manager (Debian, Ubuntu)
function apt_package_manager() {
    printf "This code updates the package list using 'apt-get update', and then prompts the user to choose an action (either install a package, remove a package, or upgrade all installed packages).\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'action'. The '-p' flag specifies that the string 'Do you want to (1) install a package, (2) remove a package, or (3) upgrade all installed packages? ' should be displayed as a prompt before reading the input.\n\nThe 'if', 'elif', and 'else' statements are used to specify different actions based on the value of the 'action' variable. If 'action' is equal to '1', the code prompts the user to enter the name of a package to install and then installs the package using 'apt-get install'. If 'action' is equal to '2', the code prompts the user to enter the name of a package to remove and then removes the package using 'apt-get remove'. If 'action' is equal to '3', the code upgrades all installed packages using 'apt-get upgrade'. If 'action' is none of these, the code prints an error message and exits the function using 'return'.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Update the package list
        sudo apt-get update

        # Prompt the user to choose an action
        read -p "Do you want to (1) install a package, (2) remove a package, or (3) upgrade all installed packages? " action

        # Check the user's answer
        if [ "$action" == "1" ]; then
            # Install a package
            read -p "Enter the name of the package you want to install: " package
            sudo apt-get install "$package"
        elif [ "$action" == "2" ]; then
            # Remove a package
            read -p "Enter the name of the package you want to remove: " package
            sudo apt-get remove "$package"
        elif [ "$action" == "3" ]; then
            # Upgrade all installed packages
            sudo apt-get upgrade
        else
            echo "Error: Invalid input"
            return
        fi

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            apt_package_manager

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            apt_package_manager
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 43 ###

####################################################

# Function for pacman package manager (Arch Linux)
function pacman_package_manager() {
    printf "This code updates the package list using 'pacman -Sy', and then prompts the user to choose an action (either install a package, remove a package, or upgrade all installed packages).\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'action'. The '-p' flag specifies that the string 'Do you want to (1) install a package, (2) remove a package, or (3) upgrade all installed packages? ' should be displayed as a prompt before reading the input.\n\nThe 'if', 'elif', and 'else' statements are used to specify different actions based on the value of the 'action' variable. If 'action' is equal to '1', the code prompts the user to enter the name of a package to install and then installs the package using 'pacman -S'. If 'action' is equal to '2', the code prompts the user to enter the name of a package to remove and then removes the package using 'pacman -R'. If 'action' is equal to '3', the code upgrades all installed packages using 'pacman -Syu'. If 'action' is none of these, the code prints an error message and exits the function using 'return'.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Update the package list
        sudo pacman -Sy

        # Prompt the user to choose an action
        read -p "Do you want to (1) install a package, (2) remove a package, or (3) upgrade all installed packages? " action

        # Check the user's answer
        if [ "$action" == "1" ]; then
            # Install a package
            read -p "Enter the name of the package you want to install: " package
            sudo pacman -S "$package"
        elif [ "$action" == "2" ]; then
            # Remove a package
            read -p "Enter the name of the package you want to remove: " package
            sudo pacman -R "$package"
        elif [ "$action" == "3" ]; then
            # Upgrade all installed packages
            sudo pacman -Syu
        else
            echo "Error: Invalid input"
            return
        fi

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            pacman_package_manager
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            pacman_package_manager
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 44 ###

####################################################

# Function for rpm package manager (Red Hat, CentOS)
function rpm_package_manager() {
    printf "This code updates the package list using 'rpm -Uvh', prompts the user to enter the name of a package to install, and then installs the package using 'rpm -i'. It then prompts the user to enter the name of a package to remove, and then removes the package using 'rpm -e'.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'package_name'. The '-p' flag specifies that the string 'Enter the name of the package to install: ' or 'Enter the name of the package to remove: ' should be displayed as a prompt before reading the input.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Update the package list
        sudo rpm -Uvh

        # Prompt the user for the name of the package to install
        read -p "Enter the name of the package to install: " package_name
        # Install the package
        sudo rpm -i "$package_name"

        # Prompt the user for the name of the package to remove
        read -p "Enter the name of the package to remove: " package_name
        # Remove the package
        sudo rpm -e "$package_name"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            rpm_package_manager

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            rpm_package_manager
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 45 ###

####################################################

# Function for yum package manager (CentOS, Fedora)
function yum_package_manager() {
    printf "This code updates the package list using 'yum update', and then prompts the user to choose an action (either install a package, remove a package, or upgrade all installed packages).\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'action'. The '-p' flag specifies that the string 'Do you want to (1) install a package, (2) remove a package, or (3) upgrade all installed packages? ' should be displayed as a prompt before reading the input.\n\nThe 'if', 'elif', and 'else' statements are used to specify different actions based on the value of the 'action' variable. If 'action' is equal to '1', the code prompts the user to enter the name of a package to install and then installs the package using 'yum install'. If 'action' is equal to '2', the code prompts the user to enter the name of a package to remove and then removes the package using 'yum remove'. If 'action' is equal to '3', the code upgrades all installed packages using 'yum upgrade'. If 'action' is none of these, the code prints an error message and exits the function using 'return'.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Update the package list
        sudo yum update

        # Prompt the user to choose an action
        read -p "Do you want to (1) install a package, (2) remove a package, or (3) upgrade all installed packages? " action

        # Check the user's answer
        if [ "$action" == "1" ]; then
            # Install a package
            read -p "Enter the name of the package you want to install: " package
            sudo yum install "$package"
        elif [ "$action" == "2" ]; then
            # Remove a package
            read -p "Enter the name of the package you want to remove: " package
            sudo yum remove "$package"
        elif [ "$action" == "3" ]; then
            # Upgrade all installed packages
            sudo yum upgrade
        else
            echo "Error: Invalid input"
            return
        fi

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            yum_package_manager

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            yum_package_manager
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 46 ###

####################################################

function run_sudo() {
    printf "This code prompts the user to enter a command, and then runs the command with 'sudo' privileges.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'command'. The '-p' flag specifies that the string 'Enter the command you want to run with sudo: ' should be displayed as a prompt before reading the input.\n\nThe 'sudo' command is used to run the 'command' with 'sudo' privileges.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask for the command to run with sudo privileges
        read -p "Enter the command you want to run with sudo: " command

        # Run the command with sudo privileges
        sudo "$command"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            run_sudo
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            run_sudo
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 47 ###

####################################################

function show_calendar() {
    printf "This code prompts the user to enter a month and a year, and then displays the calendar for the specified month and year using the 'cal' command.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'month' or 'year'. The '-p' flag specifies that the string 'Enter month (1-12): ' or 'Enter year: ' should be displayed as a prompt before reading the input.\n\nThe 'cal' command is used to display the calendar for the specified month and year. The 'month' and 'year' variables are passed as arguments to the 'cal' command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for the month and year
        read -p "Enter month (1-12): " month
        read -p "Enter year: " year

        # Display the calendar for the specified month and year
        cal "$month" "$year"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            show_calendar

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            show_calendar
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 48 ###

####################################################

function create_alias() {
    printf "This code prompts the user for an alias and a command, adds the alias to the '.bashrc' file, and then reloads the '.bashrc' file to apply the new alias.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'alias' or 'command'. The '-p' flag specifies that the string 'Enter the desired alias: ' or 'Enter the command for the alias: ' should be displayed as a prompt before reading the input.\n\nThe 'echo' command is used to append the string 'alias ${alias}='${command}'' to the '.bashrc' file. The '>>' operator is used to append the string to the file rather than overwriting it. The '~/' preceding '.bashrc' specifies the home directory of the current user.\n\nThe 'source' command is used to execute the '.bashrc' file and apply any changes.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the desired alias and command
        read -p "Enter the desired alias: " alias
        read -p "Enter the command for the alias: " command

        # Add the alias to the .bashrc file
        echo "alias ${alias}='${command}'" >>~/.bashrc

        # Reload the .bashrc file to apply the new alias
        source ~/.bashrc

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            create_alias

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            create_alias
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 49 ###

####################################################

function dd_command() {
    printf "This code prompts the user for the path to an input file and the path to an output file, and then runs the 'dd' command with the user-specified input and output files.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'input_file' or 'output_file'. The '-p' flag specifies that the string 'Enter the path to the input file: ' or 'Enter the path to the output file: ' should be displayed as a prompt before reading the input.\n\nThe 'dd' command is used to copy the input file to the output file. The 'if' and 'of' flags are used to specify the input file and output file, respectively. The variables 'input_file' and 'output_file' are passed as arguments to the 'dd' command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the input file
        read -p "Enter the path to the input file: " input_file
        # Prompt the user for the output file
        read -p "Enter the path to the output file: " output_file
        # Run the dd command with the user-specified input and output files
        dd if="$input_file" of="$output_file"

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            dd_command

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            dd_command
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 50 ###

####################################################

function whereis_command() {
    printf "This code prompts the user for a command and then uses the 'whereis' command to locate the binary, source, and manual pages for the specified command.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'command'. The '-p' flag specifies that the string 'Enter a command: ' should be displayed as a prompt before reading the input.\n\nThe 'whereis' command is used to locate the binary, source, and manual pages for the specified command. The 'command' variable is passed as an argument to the 'whereis' command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Ask the user for a command
        read -p "Enter a command: " command

        # Use the whereis command to locate the binary, source, and manual pages for the specified command
        whereis $command

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            whereis_command
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            whereis_command
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 51 ###

####################################################

function whatis() {
    printf "This code prompts the user for a command and then checks if a command has been provided. If no command is provided, it prints an error message. If a command is provided, it runs the 'man -f' command on it.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'command'. The '-p' flag specifies that the string 'Enter a command: ' should be displayed as a prompt before reading the input.\n\nThe 'if' statement is used to check if the 'command' variable is empty. The '-z' operator checks if the string is empty. If the 'command' variable is empty, the 'echo' command is run to print an error message. If the 'command' variable is not empty, the 'man -f' command is run on the 'command'. The 'man -f' command displays the manual page for the specified command and its brief description.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for a command
        read -p "Enter a command: " command
        # Check if a command has been provided
        if [ -z "$command" ]; then
            # If no command is provided, print an error message
            echo "Error: No command provided"
        else
            # If a command is provided, run the 'whatis' command on it
            man -f "$command"
        fi

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            whatis
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            whatis
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 52 ###

####################################################

function top() {
    printf "This code prompts the user for any additional flags they want to use with the 'top' command and then displays active processes live with their system usage using the 'top' command.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'flags'. The '-p' flag specifies that the string 'Enter any additional flags for the top command (e.g. -n1): ' should be displayed as a prompt before reading the input.\n\nThe 'top' command is used to display active processes live with their system usage. The '-b' flag specifies that the output should be sent to stdout in batch mode. The 'flags' variable is passed as an argument to the 'top' command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for any additional flags they want to use with the top command
        read -p "Enter any additional flags for the top command (e.g. -n1): " flags

        # Display active processes live with their system usage
        top -b $flags

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
        linux

    else
        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            top
        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            top
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 53 ###

####################################################

function add_user() {
    printf "This code prompts the user for a username and the user's full name and then creates the user with the provided username and full name using the 'useradd' command.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'username' or 'fullname'. The '-p' flag specifies that the string 'Enter the username: ' or 'Enter the user's full name: ' should be displayed as a prompt before reading the input.\n\nThe 'useradd' command is used to create a new user. The '-c' flag specifies the user's full name. The 'username' and 'fullname' variables are passed as arguments to the 'useradd' command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the username and full name
        read -p "Enter the username: " username
        read -p "Enter the user's full name: " fullname

        # Create the user with the provided username and full name
        useradd -c "$fullname" $username

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            add_user

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            add_user
        fi
    fi

}

# --------------------------------------------------------------- #

####################################################

### 54 ###

####################################################

function modify_user() {
    printf "This code prompts the user for a username and the new full name for the user and then modifies the user's full name using the 'usermod' command.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'username' or 'fullname'. The '-p' flag specifies that the string 'Enter the username: ' or 'Enter the new full name for the user: ' should be displayed as a prompt before reading the input.\n\nThe 'usermod' command is used to modify a user. The '-c' flag specifies the user's new full name. The 'username' and 'fullname' variables are passed as arguments to the 'usermod' command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the username and the new full name
        read -p "Enter the username: " username
        read -p "Enter the new full name for the user: " fullname

        # Modify the user's full name
        usermod -c "$fullname" $username

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            modify_user

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            modify_user
        fi
    fi
}

# --------------------------------------------------------------- #

####################################################

### 55 ###

####################################################

function set_password() {
    printf "This code prompts the user for a username and a new password for the user, and then updates the password for the specified user using the 'passwd' command.\n\nThe 'read' command is used to read a line of input from the user and store it in a variable called 'username' or 'password'. The '-p' flag specifies that the string 'Enter the username: ' or 'Enter the new password: ' should be displayed as a prompt before reading the input.\n\nThe 'echo' command is used to output the 'password' variable. The '|' operator is used to pipe the output of the 'echo' command to the 'passwd' command. The 'passwd' command is used to update the password for the specified user. The '--stdin' flag specifies that the password should be read from standard input. The 'username' variable is passed as an argument to the 'passwd' command.\n"

    echo ""
    read -p "Do you still want to run this command? (yes/no) " run_command

    # Check the user's answer
    if [ "$run_command" == "yes" ]; then

        # Prompt the user for the username and new password
        read -p "Enter the username: " username
        read -p "Enter the new password: " password

        # Use the passwd command to update the password for the specified user
        echo "$password" | passwd "$username" --stdin

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
        linux
    else

        # Check the user's answer
        if [[ "$done" == "no" ]] || [[ "$done" == "n" ]] || [[ "$done" == "No" ]] || [[ "$done" == "N" ]]; then
            # Return to the main menu
            clear
            linux_banner
            set_password

        else
            # The user entered an invalid answer
            invalid_answer
            clear
            linux_banner
            set_password
        fi
    fi

}

# --------------------------------------------------------------- #

#####################################################################################################################################################################
