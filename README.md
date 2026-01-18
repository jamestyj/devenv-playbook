# devenv-playbook [![Lint](https://github.com/jamestyj/devenv-playbook/actions/workflows/lint.yml/badge.svg)](https://github.com/jamestyj/devenv-playbook/actions/workflows/lint.yml)

A collection of Ansible playbooks to automate the setup of a productive development environment on Windows Subsystem for Linux (WSL).

## 🚀 Features

- **Shell:** Zsh with Oh-My-Zsh and productivity plugins:
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
  - `fzf-tab`
- **Package Manager:** Homebrew (Linuxbrew)
- **CLI Tools:**
  - `bun` (JavaScript runtime)
  - `btop` (Resource monitor)
  - `ripgrep` (Modern grep)
  - `fd` (Modern find)
  - `bat` (Modern cat)
  - `eza` (Modern ls)
  - `sd` (Modern sed)
  - `neovim` (Text editor)
  - `fzf` (Fuzzy finder)

## 🛠️ Getting Started

### 1. Install Ubuntu in WSL

If you haven't already, install the default Ubuntu distribution by running the following commands in Windows Terminal:

```Powershell
wsl --install
wsl -d Ubuntu
```

### 2. Prerequisites

Before running the playbook, ensure you have:
1. Copied your SSH keys to `~/.ssh/`.
2. Installed Git: `sudo apt update && sudo apt install git -y`.

### 3. Installation

1. Checkout this repository:
   ```bash
   git clone https://github.com/jamestyj/devenv-playbook.git
   cd devenv-playbook
   ```

2. Install Ansible:
   Follow the [official Ubuntu installation guide](https://docs.ansible.com/projects/ansible/latest/installation_guide/installation_distros.html#installing-ansible-on-ubuntu).

3. Run the setup script:
   ```bash
   ./setup.sh
   ```

## 🛠️ Development

### Git Hooks

This project uses a native Git pre-commit hook to run syntax checks and `ansible-lint` before every commit.

To install the hook, run:
```bash
./hooks/install-pre-commit.sh
```

## 📝 TODO

- [ ] Copy `.gitconfig`
- [ ] Install `opencode`
- [ ] Install tmux config / catppuccin
- [ ] Detailed Neovim configuration (LSP, plugins)
  - [Dotfyle - Trending Colorschemes](https://dotfyle.com/neovim/colorscheme/trending)
  - [jdhao/nvim-config](https://github.com/jdhao/nvim-config)
