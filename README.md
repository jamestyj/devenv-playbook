# devenv-playbook [![Lint](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml)

A collection of Ansible playbooks to automate the setup of a productive
development environment on Windows Subsystem for Linux (WSL) and macOS.

## Features

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
  - **Claude Code** (Anthropic's CLI for Claude, with custom statusline showing
    git status, API usage, and context window)
  - **Claude Usage Tracker** (Claude API usage monitoring app, macOS only)
  - **opencode** (AI coding assistant)
  - **cmux** (Ghostty-based terminal with AI agent notifications, macOS only)
- **Development Stack:**
  - **Editor:** `neovim` (nvim)
  - **JavaScript:** `bun`, `npm`, `pnpm`
  - **Python:** `uv`
  - **Formatters:** `prettier`
- **Windows (from WSL):**
  - **oh-my-posh** for PowerShell (Catppuccin Mocha theme)
  - **Meslo Nerd Font** auto-installed for Windows Terminal
- **System Configuration:**
  - SSH Keychain management (SSH agent)
  - Locale configuration (`en_US.UTF-8`)
  - Git configuration (`.gitconfig`)

## Configuration

Before running the playbook, update `group_vars/all.yml` with your personal
settings:

```yaml
git_user_name: "Your Name"
git_user_email: "your.email@example.com"
```

For **Claude Code**, place your Anthropic API key in
`~/.config/claude-code/api-key` before running the playbook, or set
`ANTHROPIC_API_KEY` manually after installation.

For **opencode**, place your `auth.json` at `~/.local/share/opencode/auth.json`
before running the playbook, or configure it manually after installation.

## Getting Started (WSL)

### Install a WSL distribution

Install a WSL distribution by running the following command in
Windows Terminal:

| Distro | Command                    |
| ------ | -------------------------- |
| Ubuntu | `wsl --install`            |
| Fedora | `wsl --install -d Fedora`  |

Then launch it:

```Powershell
wsl -d <distro>
```

### Run script

1. Checkout Git repository.
2. Run setup script. Enter your SSH passphrase and root password when
   prompted.

Run these commands:

```Bash
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
cd ~ && git clone https://github.com/jamestyj/devenv-playbook.git && cd devenv-playbook
./setup.sh
```

## Getting Started (macOS)

### Prerequisites

Install Xcode Command Line Tools and Homebrew:

```bash
xcode-select --install
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Run script

1. Checkout Git repository.
2. Run setup script. Enter your password when prompted.

Run these commands:

```bash
ssh-keyscan -t ed25519 github.com >> ~/.ssh/known_hosts
cd ~ && git clone https://github.com/jamestyj/devenv-playbook.git && cd devenv-playbook
./setup.sh
```

## Post-Install

### Windows Terminal (WSL)

After running the playbook on WSL, set your Windows Terminal font to
**MesloLGM Nerd Font** in Settings > Profiles > Defaults > Appearance > Font
face. This is required for oh-my-posh glyphs to render correctly in PowerShell.

### Neovim + NvChad

1. Run :MasonInstallAll and :TSInstallAll command after lazy.nvim finishes
   downloading plugins.
2. Suggested plugins to install:
   - **Misc**: tree-sitter-cli, glow, jq, prettier
   - **DevOps**: ansible-lint, ansible-language-server, bash-language-server,
     shellcheck, yamllint
   - **Web Dev**: astro-language-server, typescript-language-server, css-lsp,
     html-lsp, tailwindcss-language-server, eslint-lsp, jsonlint, markdownlint

## Development

### Git Hooks

A Git pre-commit hook is used to run syntax checks and `ansible-lint` before
every commit. To set up the hook, run:

```bash
./hooks/install-pre-commit.sh
```

### Ansible-lint dependencies for VS Code and derivatives (WSL)

**Ubuntu:**

```Bash
sudo apt update
sudo apt install pipx python3-venv -y
pipx install --include-deps ansible-dev-tools
```

**Fedora:**

```Bash
sudo dnf install pipx python3-virtualenv -y
pipx install --include-deps ansible-dev-tools
```

## Fonts

Starship, Catppuccin, and eza use many special glyphs (icons) for Git, Python,
Rust, etc. If you see broken squares or weird characters, it's because your
terminal font doesn't support them. To fix this:

1. Download a font from [Nerd Fonts](https://www.nerdfonts.com/) (e.g., FiraCode
   Nerd Font or JetBrainsMono Nerd Font).

2. Install the font, then open your Terminal Settings and set the "Font face" to
   the Nerd Font version.

3. In VS Code: Go to Settings, search for terminal.integrated.fontFamily, and
   set it to your Nerd Font (e.g., 'FiraCode Nerd Font').

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file
for details.
