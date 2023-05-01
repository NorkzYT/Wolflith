DOCKER_USERNAME ?= norkz
APPLICATION_NAME ?= Launchpad
GIT_HASH ?= $(shell git log --format="%h" -n 1)

### Comments ###

# Command names are listed below:

# --------------------------------------------------------------------------------------

help:
	@echo "\Bash Scripts\n"
	@echo "make setup # Will install required dependencies and setup the repo with your directory location"
	@echo "make setup-machines # Will setup machines with the default settings"
	@echo "\n\Ansible\n"
	@echo "make ansible-1password # Will install 1password"
	@echo "make ansible-add-execute-permission # Will add execute permission to a file"
	@echo "make ansible-ansible-community # Will install ansible community"
	@echo "make ansible-ansible-upgrade-install # Will upgrade ansible"
	@echo "make ansible-apt # Will install apt packages"
	@echo "make ansible-binfmt # Will install binfmt"
	@echo "make ansible-docker-network # Will create a docker network"
	@echo "make ansible-docker-update # Will update docker"
	@echo "make ansible-docker # Will install docker unless it is already installed"
	@echo "make ansible-fail2ban # Will install fail2ban"
	@echo "make ansible-first-time-docker-container-setup # Will setup multiple docker containers such as Tailscale, Portainer, etc."
	@echo "make ansible-iftop # Will install iftop"
	@echo "make ansible-lvm-fix # Will fix lvm"
	@echo "make ansible-oh-my-zsh # Will install oh-my-zsh"
	@echo "make ansible-password-change # Will change the given users password"
	@echo "make ansible-pihole-update # Will update pihole"
	@echo "make ansible-qemu-guest-agent # Will install qemu-guest-agent"
	@echo "make ansible-reboot-required # Will check if reboot is required"
	@echo "make ansible-reboot # Will reboot the machines"
	@echo "make ansible-resize-lvm # Will resize lvm"
	@echo "make ansible-ssh-get-key # Will get ssh key from 1password and add it to the ssh_keys directory"
	@echo "make ansible-timezone # Will set timezone"
	@echo "make ansible-user-dir # Will create user dir"
	@echo "make ansible-zsh # Will install zsh"

# -------------------------------------------------------------------------------------- 
# --- Bash Scripts ---
# --------------------------------------------------------------------------------------

setup: setup.sh
	chmod +x setup.sh
	./setup.sh

setup-machines:
	bash ./Scripts/Ansible/FirstTimeSetup/NewMachines.sh

# -------------------------------------------------------------------------------------- 
# --- Ansible Playbooks ---
# --------------------------------------------------------------------------------------

ansible-1password:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/1password.yml

ansible-add-execute-permission:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/add-execute-permission.yml

ansible-ansible-community:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/ansible-community.yml

ansible-ansible-upgrade-install:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/ansible-upgrade-install.yml

ansible-apt:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/apt.yml

ansible-bash-script:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/bash-script.yml

ansible-binfmt:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/binfmt.yml

ansible-docker-network:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/docker-network.yml

ansible-docker-update:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/docker-update.yml

ansible-docker:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/docker.yml

ansible-fail2ban:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/fail2ban.yml

ansible-first-time-docker-container-setup:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/first-time-docker-container-setup.yml

ansible-iftop:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/iftop.yml

ansible-lvm-fix:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/lvm-fix.ym

ansible-oh-my-zsh:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/oh-my-zsh.yml

ansible-password-change:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/password-change.yml

ansible-pihole-update:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/pihole-update.yml

ansible-qemu-guest-agent:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/qemu-guest-agent.yml

ansible-reboot-required:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/reboot-required.yml

ansible-reboot:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/reboot.yml

ansible-resize-lvm:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/resize-lvm.yml

ansible-ssh-get-key:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/ssh-get-key.yml

ansible-timezone:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/timezone.yml

ansible-user-dir:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/user-dir.yml

ansible-zsh:
	ansible-playbook /home/user/Launchpad/Ansible/playbooks/zsh.yml

# --------------------------------------------------------------------------------------