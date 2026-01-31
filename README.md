# devenv-playbook [![Lint](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml)

A collection of Ansible playbooks to automate the setup of a productive
development environment on Windows Subsystem for Linux (WSL) and macOS.

## 🚀 Features

- **Shell & Prompt:**
  - **Zsh** with Oh-My-Zsh
  - Zsh productivity plugins: `zsh-autosuggestions`, `zsh-syntax-highlighting`,
    `fzf-tab`, `zsh-eza`
  - **Starship** prompt (Catppuccin theme)
- **Terminal Multiplexer:**
  - **tmux** with Catppuccin theme and automatic session management
- **Package Manager:**
  - **Homebrew** (consistent package management across macOS and Linux)
- **CLI Tools:**
  - **Navigation & Search:** `ripgrep` (rg), `fd` (modern find), `fzf` (fuzzy
    finder)
  - **System Monitoring:** `btop` (modern htop), `htop`, `gdu` (disk usage),
    `fastfetch`
  - **File Management:** `eza` (modern ls), `bat` (modern cat)
  - **Utilities:** `glow` (markdown renderer)
- **AI Tools:**
  - **opencode** (AI assistant with API key)
- **Development Stack:**
  - **Editor:** `neovim` (nvim)
  - **JavaScript:** `bun`, `npm`, `pnpm`
  - **Python:** `uv`
  - **Formatters:** `prettier`
- **System Configuration:**
  - SSH Keychain management (SSH agent)
  - Locale configuration (`en_US.UTF-8`)
  - Git configuration (`.gitconfig`)

## 🛠️ Getting Started (WSL)

### Install Ubuntu

Install the default Ubuntu distribution by running the following commands in
Windows Terminal:

```Powershell
wsl --install
wsl -d Ubuntu
```

### Run script

1. Copy existing SSH keys from Windows host for Github private repository access.
2. Checkout Git repository.
3. Run setup script. Enter your SSH passpharse and root password when prompted.

Run these commands:
```Bash
mkdir -p ~/.ssh/ && cp /mnt/c/Users/<your-username>/.ssh/id_ed25519* ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
cd ~ && git clone https://github.com/jamestyj/devenv-playbook.git && cd devenv-playbook
./setup.sh
```

## 🛠️ Getting Started (macOS)

### Prerequisites

Install Xcode Command Line Tools and Homebrew:

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Run script

1. Copy or generate SSH keys for Github private repository access.
2. Checkout Git repository.
3. Run setup script. Enter your password when prompted.

Run these commands:

```bash
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
cd ~ && git clone https://github.com/jamestyj/devenv-playbook.git && cd devenv-playbook
./setup.sh
```

## 🛠️ Post-Install

### Neovim + NvChad

1. Run :MasonInstallAll and :TSInstallAll command after lazy.nvim finishes
   downloading plugins.
2. Suggested plugins to install:
   - **Misc**: tree-sitter-cli, glow, jq, prettier
   - **DevOps**: ansible-lint, ansible-language-server, bash-language-server,
     shellcheck, yamllint
   - **Web Dev**: astro-language-server, typescript-language-server, css-lsp,
     html-lsp, tailwindcss-language-server, eslint-lsp, jsonlint, markdownlint

## 🛠️ Development

### Git Hooks

A Git pre-commit hook is used to run syntax checks and `ansible-lint` before
every commit. To install (symlink) the hook, run:

```bash
./hooks/install-pre-commit.sh
```

### Ansible-lint dependencies for VS Code and derivatives (WSL)

```Bash
sudo apt update
sudo apt install pipx python3-venv -y
pipx install --include-deps ansible-dev-tools
```

## 📝 Fonts

Starship, Catppuccin, and eza use many special glyphs (icons) for Git, Python,
Rust, etc. If you see broken squares or weird characters, it's because your
terminal font doesn't support them. To fix this:

1. Download a font from [Nerd Fonts](https://www.nerdfonts.com/) (e.g., FiraCode
   Nerd Font or JetBrainsMono Nerd Font).

2. Install the font, then open your Terminal Settings and set the "Font face" to
   the Nerd Font version.

3. In VS Code: Go to Settings, search for terminal.integrated.fontFamily, and
   set it to your Nerd Font (e.g., 'FiraCode Nerd Font').
