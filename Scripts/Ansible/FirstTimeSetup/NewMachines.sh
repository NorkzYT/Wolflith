#!/bin/bash

# ------------------------------------------------------------------------------------------------------------------------ #

# Runs the the following Ansible playbooks in order which is only for every new machine that needs to be setup.

# ------------------------------------------------------------------------------------------------------------------------ #

# Prompt user for the directory location of the Launchpad GitHub repository
read -p "Enter the directory location of the Launchpad repository: " directory_location

# Validate the directory location
if [ ! -d "$directory_location" ]; then
    echo "Invalid directory location. Please provide an existing directory."
    exit 1
fi

# This ansible playbook updates the package cache and upgrades all installed packages to their latest versions on all specified hosts.
# It uses the apt module and the become: true option to run with elevated privileges.
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/apt.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# This ansible playbook configures time synchronization on all hosts specified in the hosts field.
# It sets the timezone to America/NewYork, stops and starts the systemd-timesyncd service, and copies over a configuration file for timesyncd, which is a daemon that synchronizes the system clock with a remote server using the Network Time Protocol (NTP).
# The configuration file specifies the remote servers to use for time synchronization.
# The become option allows the tasks to run with elevated privileges, which may be necessary to modify system settings and control services.
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/timezone.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# This playbook installs the fail2ban package, creates local copies of the fail2ban and jail configuration files, -
# updates the backend in the jail.local configuration file, and checks the status of fail2ban and the sshd service.
# It will run on all hosts in the inventory with sudo privileges.
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/fail2ban.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# This ansible playbook creates a user on the host machine, prompts the user to enter a password, -
# switches to the user, and creates a directory in the user's home directory, .
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/user-dir.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# This ansible playbook upgrades the ansible package to the latest version or installs it on all specified hosts.
# It uses the apt module to manage the ansible package, setting the state parameter to 'latest' to upgrade to the latest version. The hosts field specifies that the playbook will run on all specified hosts.
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/ansible-upgrade-install.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# The provided YAML code lists collections (i.e., "ansible.utils", "community.general", "ansible.posix", -
# and "kubernetes.core") that are required for a certain task or project, and the "requirements.yml" file is used to specify these collections so that they can be installed and made available for use in the project.
ansible-galaxy install -r $directory_location/Launchpad/Ansible/collections/requirements.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# This ansible playbook installs Oh-My-Zsh, a framework for managing the Z shell (zsh) configuration, on all hosts specified in the hosts field for the user.
# It includes a pre-defined role called gantsign.oh-my-zsh that sets up Oh-My-Zsh as the default shell for the specified user and is assumed to have already been installed on the controller using the ansible-galaxy command.
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/oh-my-zsh.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# This ansible playbook clones a Git repository hosted on GitLab to the local host.
# It consists of a single task that uses the git module to clone the repository to the specified location on the local host.
# The playbook can be used to download a copy of the Git repository to the local host.
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/git-repo-pull.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# This is an ansible playbook that runs the "chmod" command to add execute permissions to all bash files in the "$directory_location/Launchpad/" directory on the local host.
ansible-playbook $directory_location/Launchpad/Ansible/playbooks/add-execute-permission.yml -i $directory_location/Launchpad/Ansible/inventory/hosts

# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------------------ #
