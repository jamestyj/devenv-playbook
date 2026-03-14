#!/bin/bash

# Bootstrap a development environment by installing Ansible (if needed),
# pulling required Galaxy collections, and running the local playbook.

set -euo pipefail

# Install Ansible if not already present
if ! command -v ansible &> /dev/null; then
  if command -v brew &> /dev/null; then
    echo "Installing Ansible via Homebrew..."
    brew install ansible
  else
    echo "Installing Ansible via apt..."
    sudo apt update && sudo apt install ansible -y
  fi
fi

echo "Installing Ansible Galaxy collections..."
ansible-galaxy collection install -r requirements.yml

ANSIBLE_OPTIONS=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ANSIBLE_OPTIONS="-K"
fi

echo "Running playbook..."
ansible-playbook local.yml $ANSIBLE_OPTIONS

echo "Setup complete!"
