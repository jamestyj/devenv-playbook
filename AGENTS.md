# AGENTS.md

## Build, Lint, and Test Commands

### Running the Playbook
```bash
ansible-playbook local.yml -K
ansible-playbook --syntax-check local.yml
ansible-playbook local.yml --check
ansible-playbook local.yml --tags zsh
ansible-playbook local.yml -v
```

### Linting
```bash
ansible-lint
ansible-lint -r requirements.yml
ansible-playbook --syntax-check local.yml
```

### Pre-commit Hook
```bash
./hooks/install-pre-commit.sh
./hooks/pre-commit
```

### Testing Ansible Modules
```bash
ansible-playbook local.yml --step
ansible-playbook local.yml --diff
ansible-playbook local.yml --check
```

## Code Style Guidelines

### File Structure
- All YAML files must start with `---` header
- Use 2-space indentation (Ansible default)
- No trailing whitespace
- Use Unix line endings (LF)

### Naming Conventions
- Playbooks: kebab-case (`local.yml`, `setup.yml`)
- Roles: kebab-case (`zsh`, `linux`, `macOS`, `utils`)
- Tasks: `"role: Description"` format
- Variables: snake_case (`homebrew_prefix`, `zshrc_d_prefix`)
- Modules: `ansible.builtin.` for core, `community.general.` for community

### Import and Include
```yaml
- ansible.builtin.include_tasks: task_file.yml
- ansible.builtin.include_role:
    name: role_name
    tasks_from: specific_task.yml
```

### Task Structure
```yaml
- name: "role: Description"
  ansible.builtin.module_name:
    parameter: value
  become: true
  args:
    creates: path/to/file
    executable: /bin/bash
  when: condition
  loop: items
```

### Error Handling
- Use `become: true` for elevated privileges
- Use `args: creates:` to prevent idempotency issues
- Use `set -o pipefail` in shell commands
- Use `ignore_errors: yes` only when necessary

### Configuration File Management
```yaml
- ansible.builtin.lineinfile:
    path: ~/.config/file.conf
    regexp: '^pattern='
    line: 'replacement'
    state: present
    backup: yes

- ansible.builtin.copy:
    src: template.j2
    dest: /path/to/file
    mode: "0644"
    owner: user
    group: group
```

### Git Operations
```yaml
- ansible.builtin.git:
    repo: https://github.com/user/repo.git
    dest: /path/to/destination
    update: yes
    version: main
```

### Package Management
```yaml
- ansible.builtin.package:
    name:
      - package1
      - package2
    state: present

- community.general.homebrew:
    name:
      - package1
      - package2
    state: present
    update_homebrew: yes
```

### File Operations
```yaml
- ansible.builtin.file:
    path: /path/to/directory
    state: directory
    mode: "0755"
    owner: user
    group: group

- ansible.builtin.file:
    path: /path/to/file
    state: absent
```

### Shell Commands
```yaml
- ansible.builtin.shell: |
    command1
    command2
  args:
    creates: /path/to/check
    executable: /bin/bash
  register: result
  changed_when: result.rc == 0
```

### Variables and Facts
- Use `ansible_facts.os_family`, `ansible_facts.user_id` for system info
- Define role variables in `vars/main.yml`, global in `group_vars/all.yml`

### Best Practices
1. **Idempotency**: Use `args: creates:` to prevent re-running successful operations
2. **Modularity**: Break tasks into smaller, reusable files
3. **Documentation**: Use descriptive task names with colons
4. **Safety**: Use `become: true` only when necessary
5. **Testing**: Run `ansible-playbook --check` before applying changes
6. **Linting**: Run `ansible-lint` before committing
