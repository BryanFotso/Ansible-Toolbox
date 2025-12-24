# Ansible Toolbox (Docker, Terraform, ...)

Ce depot fournit une toolbox Ansible pour installer plusieurs outils DevOps sur Ubuntu/Debian
(local, VM, WSL). Chaque outil est encapsule dans un role, ce qui rend l'ensemble facile
à etendre.

## Objectifs
- 1 outil = 1 role Ansible
- Un playbook global pour installer plusieurs outils conditionnellement
- Configuration par environnement (local / prod)
- Documentation simple pour debutants

## Structure du depot
- `inventory/` : inventaires par environnement (`local.ini`, `prod.ini`)
- `group_vars/` : variables globales et par environnement
- `playbooks/` : playbooks d'entree (`site.yml`) et playbooks par outil
- `roles/` : roles `common`, `docker`, `terraform`
- `ansible.cfg`, `Makefile`, `.gitignore`, `README.md`

## Prerequis
- Ubuntu/Debian
- Python 3
- Acces sudo

## Choisir les outils a installer
Modifiez `group_vars/local.yml` ou `group_vars/prod.yml` :

```yaml
toolbox_install:
  docker: true
  terraform: false
```

## Lancer l'installation

### Avec le Makefile (recommande)
```bash
make install
make site
```

Pour l'environnement prod :
```bash
ENV=prod make site
```

Les variables d'environnement sont chargees via `toolbox_env` (defini dans
`inventory/local.ini` ou `inventory/prod.ini`) et pointent vers `group_vars/<env>.yml`.

### Avec Ansible directement
```bash
ansible-playbook -i inventory/local.ini playbooks/site.yml --ask-become-pass
```

### Installer un outil specifique
```bash
make docker
make terraform
```

## Desinstallation
Le playbook `playbooks/uninstall.yml` utilise `toolbox_uninstall` :

```bash
ansible-playbook -i inventory/local.ini playbooks/uninstall.yml --ask-become-pass \
  -e '{"toolbox_uninstall":{"docker":true}}'
```

## Ajouter un nouvel outil
1. Creer un nouveau role dans `roles/<outil>/`.
2. Ajouter un playbook `playbooks/<outil>.yml`.
3. Declarer l'outil dans `group_vars/all.yml`.
4. Ajouter la condition dans `playbooks/site.yml`.
5. (Optionnel) Ajouter une cible dans le `Makefile`.

## Notes
- Les roles utilisent les depots officiels (Docker et HashiCorp).
- L'installation est idempotente : relancer un playbook est sans risque.
