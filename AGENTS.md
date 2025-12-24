Réponds en francais 

You are a senior DevOps engineer specialized in Ansible and Infrastructure as Code.

Context:
I currently have an Ansible repository dedicated only to to install multiple DevOps tools
(Docker + Docker Compose, Terraform now, and more tools later) on a local Linux machine (Ubuntu / WSL).

Goal:
Design a clean, professional, production-ready Ansible repository structure that follows best practices:
- 1 tool = 1 Ansible role
- A global playbook to install multiple tools conditionally
- Environment-based configuration (local / prod)
- Easy extensibility (adding new tools should be trivial)
- Beginner-friendly documentation

Required repository structure:
- inventory/ (local.ini, prod.ini)
- group_vars/ (all.yml, local.yml, prod.yml)
- playbooks/
  - site.yml (main entrypoint)
  - docker.yml
  - terraform.yml
  - uninstall.yml (if relevant)
- roles/
  - common/ (shared prerequisites: apt, curl, gpg, ca-certificates)
  - docker/
  - terraform/
- ansible.cfg
- Makefile
- .gitignore
- README.md

Functional requirements:
1. Docker role:
   - Install Docker using the official repository
   - Install Docker Compose (plugin)
   - Ensure Docker service is enabled and running
   - Add current user to docker group
2. Terraform role:
   - Install Terraform using HashiCorp official repository
   - Verify installation
3. common role:
   - Install common packages needed by multiple roles
4. site.yml:
   - Install tools conditionally using variables like:
     toolbox_install:
       docker: true
       terraform: true
5. group_vars:
   - Use variables to enable/disable tools per environment
6. Makefile:
   - Provide shortcuts: install ansible, run site.yml, run docker only, run terraform only
7. README.md:
   - Clear explanation for beginners
   - How to choose which tools to install
   - How to run the playbooks
   - How to add a new tool later

Output expectations:
- Generate all files with their full content
- Follow Ansible best practices (idempotency, handlers, defaults)
- Keep YAML simple and readable
- Assume Ubuntu/Debian target systems
- Do not over-engineer (no Kubernetes, no CI/CD yet)

Final instruction:
Act as if this repo will be used by a junior DevOps/Data Engineer to set up local environments safely.
Produce clean, maintainable, copy-paste-ready code.
