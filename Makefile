ANSIBLE ?= ansible-playbook
ENV ?= local
INVENTORY = inventory/$(ENV).ini
PLAYBOOK_DIR = playbooks

.PHONY: install site docker terraform uninstall check help

install:
	@echo "Installation d'Ansible (Ubuntu/Debian)"
	sudo apt update && sudo apt install -y ansible

site:
	@echo "Lancement de la toolbox (ENV=$(ENV))"
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK_DIR)/site.yml --ask-become-pass

docker:
	@echo "Installation de Docker uniquement (ENV=$(ENV))"
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK_DIR)/docker.yml --ask-become-pass

terraform:
	@echo "Installation de Terraform uniquement (ENV=$(ENV))"
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK_DIR)/terraform.yml --ask-become-pass

uninstall:
	@echo "Desinstallation des outils (ENV=$(ENV))"
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK_DIR)/uninstall.yml --ask-become-pass

check:
	@echo "Verification de syntaxe"
	$(ANSIBLE) -i $(INVENTORY) $(PLAYBOOK_DIR)/site.yml --syntax-check

help:
	@echo "Commandes disponibles :"
	@echo "  make install          # Installe Ansible"
	@echo "  make site             # Installe les outils actives dans group_vars"
	@echo "  make docker           # Installe Docker uniquement"
	@echo "  make terraform        # Installe Terraform uniquement"
	@echo "  make uninstall        # Desinstalle selon toolbox_uninstall"
	@echo "  ENV=prod make site    # Cible l'inventaire prod"
	@echo "  make check            # Syntaxe du playbook"
