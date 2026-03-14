# Contributing

Thanks for your interest in contributing to devenv-playbook! This is a
small, single-maintainer project, so the process is lightweight.

## Getting Started

1. Fork the repository and clone your fork
2. Create a feature branch: `git checkout -b my-change`
3. Make your changes
4. Push and open a pull request against `main`

## Prerequisites

- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/)
- [ansible-lint](https://ansible.readthedocs.io/projects/lint/)

## Code Style

- YAML files start with `---` and use 2-space indentation
- Task names use `"role: Description"` format
  (e.g., `"zsh: Install Oh-My-Zsh"`)
- Use fully qualified module names (`ansible.builtin.*`,
  `community.general.*`)
- Use `args: creates:` for idempotency in shell commands
- See [CLAUDE.md](CLAUDE.md) for full details

## Testing Your Changes

```bash
# Syntax check
ansible-playbook --syntax-check local.yml

# Lint
ansible-lint

# Dry run (check mode)
ansible-playbook local.yml --check

# Run a specific role
ansible-playbook local.yml --tags zsh
```

## Pre-commit Hook

Install the pre-commit hook to run `ansible-lint` automatically:

```bash
./hooks/install-pre-commit.sh
```

## Development Environment

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

## Pull Request Guidelines

- Follow [Conventional Commits](https://www.conventionalcommits.org/)
  (e.g., `feat:`, `fix:`, `docs:`)
- Keep PRs focused — one logical change per PR
- Ensure `ansible-lint` passes before submitting

## Reporting Bugs

Please open a GitHub issue and include:

- Operating system and version (macOS / WSL distro)
- Ansible version (`ansible --version`)
- Steps to reproduce the problem
- Relevant error output

## License

By contributing, you agree that your contributions will be licensed
under the [MIT License](LICENSE). No CLA or DCO is required.
