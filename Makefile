DOCKER_USERNAME ?= norkz
APPLICATION_NAME ?= Launchpad
GIT_HASH ?= $(shell git log --format="%h" -n 1)

### Comments ###

# Command names are listed below:

# --------------------------------------------------------------------------------------

help:
	@echo "\n--------------------------------------------------------------------------------------"
	@echo "\n\033[1;35m# Scripts #\033[0m\n"   # Purple color for the section header
	@echo "\033[1;32m# Will install required dependencies and setup the repo with your directory location\033[0m"   # Green color for the description
	@echo "\033[1;33mmake setup\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;34m## Hashicorp Vault ##\033[0m\n"   # Blue color for the section header
	@echo "\033[1;32m# This script extracts the names of environment variables from .env files and stores them in env_var_names.txt.\033[0m"   # Green color for the description
	@echo "\033[1;33mmake all-env-variables\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# This script authenticates to Hashicorp Vault, creates .env files from .env.example files, and retrieves secret values from Vault for environment variables in the .env files.\033[0m"   # Green color for the description
	@echo "\033[1;33mmake hashicorp-vault-pull-secrets\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# This script sets up authentication to Hashicorp Vault, copies .env.example files to .env files, and pushes environment variables to Vault.\033[0m"   # Green color for the description
	@echo "\033[1;33mmake hashicorp-vault-push-secrets\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;34m## Launchpad Repository ##\033[0m\n"   # Blue color for the section header
	@echo "\033[1;32m# This script updates the playbook files in the Launchpad repository to use 'localhost' as the host and adds 'connection: local' to each playbook.\033[0m"   # Green color for the description
	@echo "\033[1;33mmake change_hosts_to_localhost\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# This script reverts the playbook files in the Launchpad repository to use 'all' as the host and removes the 'connection: local' line from each playbook.\033[0m"   # Green color for the description
	@echo "\033[1;33mmake change_hosts_to_all\033[0m"   # Yellow color for the command
	@echo "--------------------------------------------------------------------------------------"
	@echo "\n\033[1;35m# Ansible #\033[0m\n"   # Blue color for the section header
	@echo "\033[1;32m# Will install 1password\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-1password\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will add execute permission to a file\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-add-execute-permission\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install ansible community\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-ansible-community\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will upgrade ansible\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-ansible-upgrade-install\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install apt packages\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-apt\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will run a bash script\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-binfmt\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will create a docker network\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-docker-network\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will update docker\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-docker-update\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install docker unless it is already installed\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-docker\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install fail2ban\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-fail2ban\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will setup multiple docker containers such as Tailscale, Portainer, etc.\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-first-time-docker-container-setup\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install iftop\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-iftop\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will fix lvm\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-lvm-fix\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install oh-my-zsh\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-oh-my-zsh\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will change the given users password\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-password-change\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will update pihole\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-pihole-update\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install qemu-guest-agent\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-qemu-guest-agent\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will check if reboot is required\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-reboot-required\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will reboot the machines\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-reboot\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will resize lvm\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-resize-lvm\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will get ssh key from 1password and add it to the ssh_keys directory\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-ssh-get-key\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will set timezone\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-timezone\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will create user directory\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-user-dir\033[0m"   # Yellow color for the command
	@echo "\n"
	@echo "\033[1;32m# Will install zsh\033[0m"   # Green color for the description
	@echo "\033[1;33mmake ansible-zsh\033[0m"   # Yellow color for the command
	@echo "--------------------------------------------------------------------------------------"
	@echo "\n"

# -------------------------------------------------------------------------------------- 
# --- Bash Scripts ---
# --------------------------------------------------------------------------------------

setup: ./Auto/setup.sh
	chmod +x ./Auto/setup.sh
	./Auto/setup.sh

setup-machines:
	bash ./Scripts/Ansible/FirstTimeSetup/NewMachines.sh

change_hosts_to_localhost: ./Scripts/Ansible/change_hosts_to_localhost.sh
	chmod +x ./Scripts/Ansible/change_hosts_to_localhost.sh
	./Scripts/Ansible/change_hosts_to_localhost.sh

change_hosts_to_all: ./Scripts/Ansible/change_hosts_to_all.sh
	chmod +x ./Scripts/Ansible/change_hosts_to_all.sh
	./Scripts/Ansible/change_hosts_to_all.sh

all-env-variables: ./Scripts/Vault/auto-all-env.sh
	chmod +x ./Scripts/Vault/auto-all-env.sh
	./Scripts/Vault/auto-all-env.sh

hashicorp-vault-pull-secrets: ./Scripts/Vault/auto-pull-env.sh
	chmod +x ./Scripts/Vault/auto-pull-env.sh
	./Scripts/Vault/auto-pull-env.sh

hashicorp-vault-push-secrets: ./Scripts/Vault/auto-push-env.sh
	chmod +x ./Scripts/Vault/auto-push-env.sh
	./Scripts/Vault/auto-push-env.sh

# -------------------------------------------------------------------------------------- 
# --- Ansible Playbooks ---
# --------------------------------------------------------------------------------------

ansible-1password:
	ansible-playbook "/home/user/Launchpad/Ansible/playbooks/1password.yml" -i "/home/user/Ansible/inventory/hosts"

ansible-add-execute-permission:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/add-execute-permission.yml -i "/home/user/Ansible/inventory/hosts"

ansible-ansible-community:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/ansible-community.yml -i "/home/user/Ansible/inventory/hosts"

ansible-ansible-upgrade-install:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/ansible-upgrade-install.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-apt:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/apt.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-bash-script:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/bash-script.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-binfmt:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/binfmt.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-docker-network:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/docker-network.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-docker-update:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/docker-update.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-docker:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/docker.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-fail2ban:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/fail2ban.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-first-time-docker-container-setup:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/first-time-docker-container-setup.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-iftop:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/iftop.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-lvm-fix:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/lvm-fix.ym -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-oh-my-zsh:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/oh-my-zsh.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-password-change:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/password-change.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-pihole-update:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/pihole-update.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-qemu-guest-agent:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/qemu-guest-agent.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-reboot-required:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/reboot-required.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-reboot:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/reboot.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-resize-lvm:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/resize-lvm.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-ssh-get-key:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/ssh-get-key.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-timezone:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/timezone.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-user-dir:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/user-dir.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

ansible-zsh:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/zsh.yml -i "/home/user/Launchpad/Ansible/inventory/hosts"

# --------------------------------------------------------------------------------------