DOCKER_USERNAME ?= norkz
APPLICATION_NAME ?= Wolflith
GIT_HASH ?= $(shell git log --format="%h" -n 1)

### Help Section ###

# Use 'make help' to display the help section

help:
	@echo "\nCommands available:"
	@echo "--------------------------------------------------------------------------------------"
	@echo "\033[1;35mGeneral Commands:\033[0m"
	@echo "  \033[1;33mmake setup\033[0m - Setup the repo with required dependencies."
	@echo "  \033[1;33mmake menu\033[0m   - Start the PCSMenu."
	@echo ""
	@echo "\033[1;35mAnsible Commands:\033[0m"
	@echo "  \033[1;33mmake ansible-1password\033[0m          - Install 1password."
	@echo "  \033[1;33mmake ansible-upgrade\033[0m            - Upgrade ansible managed packages."
	@echo "  \033[1;33mmake ansible-apt\033[0m                - Run apt playbook."
	@echo "  \033[1;33mmake ansible-oh-my-zsh\033[0m          - Install oh-my-zsh."
	@echo "  \033[1;33mmake ansible-ssh-get-key\033[0m        - Get SSH keys."
	@echo "  \033[1;33mmake ansible-zsh\033[0m                - Configure zsh for 'proxmoxve'."
	@echo ""
	@echo "\033[1;35mVault Commands:\033[0m"
	@echo "  \033[1;33mmake all-env-variables\033[0m          - Extract env variables names."
	@echo "  \033[1;33mmake hashicorp-vault-pull-secrets\033[0m - Pull secrets from Hashicorp Vault."
	@echo "  \033[1;33mmake hashicorp-vault-push-secrets\033[0m - Push secrets to Hashicorp Vault."
	@echo ""
	@echo "\033[1;35mRepository Commands:\033[0m"
	@echo "  \033[1;33mmake change_hosts_to_localhost\033[0m   - Change hosts to 'localhost'."
	@echo "  \033[1;33mmake change_hosts_to_all\033[0m         - Revert hosts to 'all'."
	@echo "--------------------------------------------------------------------------------------\n"

### General Scripts ###

setup:
	@chmod +x ./Auto/setup.sh
	@./Auto/setup.sh

menu:
	@cd PCSMenu && ./PCSMenu.sh

### Ansible Commands ###

ansible-1password ansible-upgrade ansible-apt ansible-oh-my-zsh ansible-ssh-get-key ansible-zsh:
	@ansible-playbook "/opt/Wolflith/Ansible/playbooks/$(@).yml" -i "/opt/Wolflith/Ansible/inventory/hosts.yaml" $(if $(findstring zsh,$@),-l "proxmoxve",)

### Vault Commands ###

all-env-variables hashicorp-vault-pull-secrets hashicorp-vault-push-secrets:
	@chmod +x ./Scripts/Vault/$(@).sh
	@./Scripts/Vault/$(@).sh

### Repository Configuration ###

change_hosts_to_localhost change_hosts_to_all:
	@chmod +x ./Scripts/Ansible/$(@).sh
	@./Scripts/Ansible/$(@).sh