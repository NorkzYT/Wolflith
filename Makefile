DOCKER_USERNAME ?= norkz
APPLICATION_NAME ?= Launchpad
GIT_HASH ?= $(shell git log --format="%h" -n 1)

### Comments ###

# Command names are listed below:

# --------------------------------------------------------------------------------------

help:
	@echo "--------------------------------------------------------------------------------------"
	@echo "\nScripts\n"
	@echo "# Will install required dependencies and setup the repo with your directory location"
	@echo "make setup"
	@echo "\n"
	@echo "# Will change Ansible playbook hosts to localhost with connection as local"
	@echo "make change_hosts_to_localhost"
	@echo "\n"
	@echo "# Will change Ansible playbook hosts to all"
	@echo "make change_hosts_to_all"
	@echo "\n"
	@echo "# Will setup machines with the default settings"
	@echo "make setup-machines"
	@echo "--------------------------------------------------------------------------------------"
	@echo "\nAnsible\n"
	@echo "# Will install 1password"
	@echo "make ansible-1password"
	@echo "\n"
	@echo "# Will add execute permission to a file"
	@echo "make ansible-add-execute-permission"
	@echo "\n"
	@echo "# Will install ansible community"
	@echo "make ansible-ansible-community"
	@echo "\n"
	@echo "# Will upgrade ansible"
	@echo "make ansible-ansible-upgrade-install"
	@echo "\n"
	@echo "# Will install apt packages"
	@echo "make ansible-apt"
	@echo "\n"
	@echo "# Will run a bash script"
	@echo "make ansible-binfmt"
	@echo "\n"
	@echo "# Will create a docker network"
	@echo "make ansible-docker-network"
	@echo "\n"
	@echo "# Will update docker"
	@echo "make ansible-docker-update"
	@echo "\n"
	@echo "# Will install docker unless it is already installed"
	@echo "make ansible-docker"
	@echo "\n"
	@echo "# Will install fail2ban"
	@echo "make ansible-fail2ban"
	@echo "\n"
	@echo "# Will setup multiple docker containers such as Tailscale, Portainer, etc."
	@echo "make ansible-first-time-docker-container-setup"
	@echo "\n"
	@echo "# Will install iftop"
	@echo "make ansible-iftop"
	@echo "\n"
	@echo "# Will fix lvm"
	@echo "make ansible-lvm-fix"
	@echo "\n"
	@echo "# Will install oh-my-zsh"
	@echo "make ansible-oh-my-zsh"
	@echo "\n"
	@echo "# Will change the given users password"
	@echo "make ansible-password-change"
	@echo "\n"
	@echo "# Will update pihole"
	@echo "make ansible-pihole-update"
	@echo "\n"
	@echo "# Will install qemu-guest-agent"
	@echo "make ansible-qemu-guest-agent"
	@echo "\n"
	@echo "# Will check if reboot is required"
	@echo "make ansible-reboot-required"
	@echo "\n"
	@echo "# Will reboot the machines"
	@echo "make ansible-reboot"
	@echo "\n"
	@echo "# Will resize lvm"
	@echo "make ansible-resize-lvm"
	@echo "\n"
	@echo "# Will get ssh key from 1password and add it to the ssh_keys directory"
	@echo "make ansible-ssh-get-key"
	@echo "\n"
	@echo "# Will set timezone"
	@echo "make ansible-timezone"
	@echo "\n"
	@echo "# Will create user directory"
	@echo "make ansible-user-dir"
	@echo "\n"
	@echo "# Will install zsh"
	@echo "make ansible-zsh"
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

change_hosts_to_localhost: change_hosts_to_localhost.sh
	chmod +x change_hosts_to_localhost.sh
	./change_hosts_to_localhost.sh

change_hosts_to_all: change_hosts_to_all.sh
	chmod +x change_hosts_to_all.sh
	./change_hosts_to_all.sh

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