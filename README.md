# devenv-playbook

## Install Ubuntu in WSL

Install the default Ubuntu disto by running the following commands in Windows Terminal:

```Powershell
wsl --install
wsl -d Ubuntu
```

## Install

1. Copy SSH keys.
2. Install Ansible. https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu

```Bash
ansible-playbook install_bun.yml
```

TODO:
- Copy .gitconfig
- Setup zsh
- Install opencode
- Install tmux config / catppuccin
- Install neovim, rg, etc.
