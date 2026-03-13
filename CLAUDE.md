# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

devenv-playbook is an Ansible automation project for setting up a productive development environment on WSL (Windows Subsystem for Linux) and macOS. It uses Infrastructure as Code to configure shell environments, CLI tools, and development utilities.

## Commands

```bash
# Run the playbook (prompts for sudo password)
ansible-playbook local.yml -K

# Syntax check
ansible-playbook --syntax-check local.yml

# Dry run (check mode)
ansible-playbook local.yml --check

# Run specific role only
ansible-playbook local.yml --tags zsh

# Lint
ansible-lint

# Install pre-commit hook
./hooks/install-pre-commit.sh
```

## Architecture

**Playbook execution order** (`local.yml`):
1. `utils` - Installs Homebrew and development tools (ripgrep, fd, fzf, btop, neovim, etc.)
2. `zsh` - Configures shell (Oh-My-Zsh, Starship prompt, plugins)
3. `linux` - Linux-specific settings (locale, SSH keychain)

**Key directories:**
- `roles/*/tasks/` - Task implementations split into focused files (homebrew.yml, tmux.yml, git.yml, etc.)
- `roles/zsh/vars/main.yml` - Oh-My-Zsh plugin definitions
- `group_vars/all.yml` - Global variables (`homebrew_prefix`, `zshrc_d_prefix`)

**Configuration files managed:**
- `~/.zshrc.d/` - Zsh configuration snippets
- `~/.config/starship.toml` - Starship prompt config
- `~/.tmux.conf` - tmux configuration

## Code Style

- YAML files start with `---` header, use 2-space indentation
- Task names: `"role: Description"` format (e.g., `"zsh: Install Oh-My-Zsh"`)
- Variables: snake_case
- Use fully qualified module names: `ansible.builtin.` or `community.general.`
- Use `args: creates:` for idempotency in shell commands
- Run `ansible-lint` before committing (enforced by pre-commit hook)

## Linting

`.ansible-lint` skips: `yaml[indentation]`, `latest[git]`, `name[play]`, `command-instead-of-module`

## Commits

All commits MUST follow [Conventional Commits v1.0.0](https://www.conventionalcommits.org/en/v1.0.0/).

Format: `<type>[optional scope]: <description>`

Allowed types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `revert`

- Use lowercase type and description
- Do not end the description with a period
- Use `!` after type/scope for breaking changes (e.g., `feat!: remove deprecated API`)
- Add optional body/footer separated by blank lines for additional context
- Do NOT include a `Co-Authored-By` trailer in commit messages

Examples:
- `feat(client): add backup scheduling support`
- `fix: handle token expiry during long-running jobs`
- `docs: update CLAUDE.md with commit conventions`
