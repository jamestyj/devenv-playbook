# devenv-playbook [![Lint](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml/badge.svg)](https://github.com/jamestyj/devenv-playbook/actions/workflows/ansible-lint.yml) [![ShellCheck](https://github.com/jamestyj/devenv-playbook/actions/workflows/shellcheck.yml/badge.svg)](https://github.com/jamestyj/devenv-playbook/actions/workflows/shellcheck.yml)

A collection of Ansible playbooks to automate the setup of a productive
development environment on Windows Subsystem for Linux (WSL) and macOS.

## Why

Setting up a development environment by hand is tedious, error-prone,
and hard to reproduce across machines or OS reinstalls. This playbook
captures the entire setup as code so it can be run — and re-run — in a
single command. It covers both macOS and WSL, giving you a consistent,
productive experience no matter which platform you're on.

## Use Cases

- Provision a fresh laptop or WSL instance in minutes.
- Keep multiple machines (e.g., work Mac + home WSL) in sync.
- Rebuild quickly after an OS reinstall or hardware swap.
- Share a curated, opinionated tool stack with teammates or the
  community.
- Experiment with new tools — add a role, run the playbook, and
  revert if unwanted.

## Features

- **Shell & Prompt:**
  - [**Zsh**](https://www.zsh.org/) with [Oh-My-Zsh](https://ohmyz.sh/)
  - Zsh productivity plugins:
    [`zsh-autosuggestions`](https://github.com/zsh-users/zsh-autosuggestions),
    [`zsh-syntax-highlighting`](https://github.com/zsh-users/zsh-syntax-highlighting),
    [`fzf-tab`](https://github.com/Aloxaf/fzf-tab),
    [`zsh-eza`](https://github.com/z-shell/zsh-eza)
  - [**Starship**](https://starship.rs/) prompt
    ([Catppuccin](https://catppuccin.com/) theme)
- **Terminal Multiplexer:**
  - [**tmux**](https://github.com/tmux/tmux) with Catppuccin theme and
    automatic session management
- **Package Manager:**
  - [**Homebrew**](https://brew.sh/) (consistent package management across
    macOS and Linux)
- **CLI Tools:**
  - **Navigation & Search:**
    [`ripgrep`](https://github.com/BurntSushi/ripgrep) (rg),
    [`fd`](https://github.com/sharkdp/fd) (modern find),
    [`fzf`](https://github.com/junegunn/fzf) (fuzzy finder)
  - **System Monitoring:**
    [`btop`](https://github.com/aristocratos/btop) (modern htop),
    [`htop`](https://htop.dev/),
    [`gdu`](https://github.com/dundee/gdu) (disk usage),
    [`fastfetch`](https://github.com/fastfetch-cli/fastfetch)
  - **File Management:**
    [`eza`](https://github.com/eza-community/eza) (modern ls),
    [`bat`](https://github.com/sharkdp/bat) (modern cat)
  - **Utilities:**
    [`glow`](https://github.com/charmbracelet/glow) (markdown renderer)
- **AI Tools:**
  - [**Claude Code**](https://github.com/anthropics/claude-code) (Anthropic's
    CLI for Claude, with custom statusline showing git status, API usage, and
    context window)
  - [**Claude Usage Tracker**](https://github.com/hamed-elfayome/claude-usage)
    (Claude API usage monitoring app, macOS only)
  - [**opencode**](https://github.com/opencode-ai/opencode) (AI coding
    assistant)
  - [**cmux**](https://github.com/manaflow-ai/cmux) (Ghostty-based terminal
    with AI agent notifications, macOS only)
- **Development Stack:**
  - **Editor:** [`neovim`](https://neovim.io/) (nvim)
  - **JavaScript:** [`bun`](https://bun.sh/),
    [`npm`](https://www.npmjs.com/), [`pnpm`](https://pnpm.io/)
  - **Python:** [`uv`](https://github.com/astral-sh/uv)
  - **Formatters:** [`prettier`](https://prettier.io/)
- **Windows (from WSL):**
  - [**oh-my-posh**](https://ohmyposh.dev/) for PowerShell (Catppuccin Mocha
    theme)
  - [**Meslo Nerd Font**](https://github.com/ryanoasis/nerd-fonts)
    auto-installed for Windows Terminal
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

### Neovim + [NvChad](https://nvchad.com/)

1. Run :MasonInstallAll and :TSInstallAll command after
   [lazy.nvim](https://github.com/folke/lazy.nvim) finishes downloading
   plugins.
2. Suggested plugins to install:
   - **Misc**: tree-sitter-cli, glow, jq, prettier
   - **DevOps**: ansible-lint, ansible-language-server, bash-language-server,
     shellcheck, yamllint
   - **Web Dev**: astro-language-server, typescript-language-server, css-lsp,
     html-lsp, tailwindcss-language-server, eslint-lsp, jsonlint, markdownlint

## Development

### Git Hooks

A Git pre-commit hook is used to run syntax checks, `ansible-lint`, and
`shellcheck` before every commit. To set up the hook, run:

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
