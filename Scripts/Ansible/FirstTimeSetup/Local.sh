#!/bin/bash

# ------------------------------------------------------------------------------------------------------------------------ #

# Runs the the following Ansible playbooks in order which is only for every new machine that needs to be setup.

# ------------------------------------------------------------------------------------------------------------------------ #

# This is an ansible playbook that runs the "chmod" command to add execute permissions to all bash files in the "$directory_location/Wolflith/" directory on the local host.
ansible-playbook $directory_location/Wolflith/Ansible/playbooks/add-execute-permission.yml

# ------------------------------------------------------------------------------------------------------------------------ #
# ------------------------------------------------------------------------------------------------------------------------ #
