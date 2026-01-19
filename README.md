# devenv-playbook [![Lint](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml)

A collection of Ansible playbooks to automate the setup of a productive
development environment on Windows Subsystem for Linux (WSL).

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
    `neofetch`
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

### 1. Install Ubuntu

Install the default Ubuntu distribution by running the following commands in
Windows Terminal:

```Powershell
wsl --install
wsl -d Ubuntu
```

### 2. Copy SSH keys

Copy existing SSH keys from Windows host for Github private repository access:

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

## 📝 TODO

- [ ] Detailed Neovim configuration (LSP, plugins)
  - [Dotfyle - Trending Colorschemes](https://dotfyle.com/neovim/colorscheme/trending)
  - [jdhao/nvim-config](https://github.com/jdhao/nvim-config)
  - NVchad
- [ ] Support MacOS
- [ ] Test clean install on Ubuntu
