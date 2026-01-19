# devenv-playbook [![Lint](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml)

A collection of Ansible playbooks to automate the setup of a productive
development environment on Windows Subsystem for Linux (WSL).

## 🚀 Features

- **Shell:** Zsh with Oh-My-Zsh and productivity plugins:
  - `zsh-autosuggestions`
  - `zsh-syntax-highlighting`
  - `fzf-tab`
- **Package Manager:** Homebrew (Linuxbrew)
- **CLI Tools:**
  - **Navigation & Search:** `ripgrep` (rg), `fd`, `fzf`, `sd`
  - **File & System Monitoring:** `btop`, `htop`, `eza` (ls), `bat` (cat), `gdu`
    (disk usage, gdu-go)
  - **Development Tools:**
    - **Editor:** `neovim` (nvim)
    - **JavaScript:** `bun`, `npm`, `pnpm`
    - **Python:** `uv`
    - **Utilities:** `glow` (markdown renderer)

## 🛠️ Getting Started

### 1. Install Ubuntu in WSL

If you haven't already, install the default Ubuntu distribution by running the
following commands in Windows Terminal:

```Powershell
wsl --install
wsl -d Ubuntu
```

#### Install a Nerd font

Starship uses many special glyphs (icons) for Git, Python, Rust, etc. If you see
broken squares or weird characters, it's because your terminal font doesn't
support them.

1. Download a font from Nerd Fonts (e.g., FiraCode Nerd Font or JetBrainsMono
   Nerd Font).

2. On Windows (if using WSL): Install the font on Windows, then open your
   Terminal Settings and set the "Font face" to the Nerd Font version.

3. On VS Code: Go to Settings, search for terminal.integrated.fontFamily, and
   set it to your Nerd Font (e.g., 'FiraCode Nerd Font').

### 2. Copy SSH keys

```Bash
cp /mnt/c/Users/<your-username>/.ssh/id_ed25519* ~/.ssh/
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
```

### 3. Checkout repo and run setup script

```Bash
git clone https://github.com/jamestyj/devenv-playbook.git && cd devenv-playbook
./setup.sh
```

## 🛠️ Development

### Git Hooks

This project uses a native Git pre-commit hook to run syntax checks and
`ansible-lint` before every commit.

To install the hook, run:

```bash
./hooks/install-pre-commit.sh
```

### Install ansible-lint depedencies for VS Code and derivatives.

```Bash
sudo apt update
sudo apt install pipx python3-venv -y
pipx install --include-deps ansible-dev-tools
```

## 📝 TODO

- [ ] Copy `.gitconfig`
- [ ] Install `opencode`
- [ ] Detailed Neovim configuration (LSP, plugins)
  - [Dotfyle - Trending Colorschemes](https://dotfyle.com/neovim/colorscheme/trending)
  - [jdhao/nvim-config](https://github.com/jdhao/nvim-config)
  - NVchad
  - vim config
- [ ] Support MacOS
- [ ] Test clean install on Ubuntu
