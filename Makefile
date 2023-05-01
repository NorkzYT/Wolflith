DOCKER_USERNAME ?= norkz
APPLICATION_NAME ?= Launchpad
GIT_HASH ?= $(shell git log --format="%h" -n 1)

### Comments ###

# Command names are listed below:

# --------------------------------------------------------------------------------------

help:
	@echo "--------------------------------------------------------------------------------------"
	@echo "Scripts\n"
	@echo "# Will install required dependencies and setup the repo with your directory location"
	@echo "make setup"
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