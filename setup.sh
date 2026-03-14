#!/bin/bash

# Bootstrap a development environment by installing Ansible (if needed),
# pulling required Galaxy collections, and running the local playbook.

set -euo pipefail

# Install Ansible if not already present
if ! command -v ansible &> /dev/null; then
  if command -v brew &> /dev/null; then
    echo "Installing Ansible via Homebrew..."
    brew install ansible
  elif command -v dnf &> /dev/null; then
    echo "Installing Ansible via dnf..."
    sudo dnf install ansible -y
  elif command -v apt &> /dev/null; then
    echo "Installing Ansible via apt..."
    sudo apt update && sudo apt install ansible -y
  else
    echo "Error: No supported package manager found (brew, dnf, apt)."
    exit 1
  fi
fi

# Verify minimum Ansible version
MIN_ANSIBLE_VERSION="2.15"
ANSIBLE_VERSION=$(ansible --version | head -1 | grep -oE '[0-9]+\.[0-9]+')
if [ "$(printf '%s\n' "$MIN_ANSIBLE_VERSION" "$ANSIBLE_VERSION" | sort -V | head -1)" != "$MIN_ANSIBLE_VERSION" ]; then
  echo "Error: Ansible >= $MIN_ANSIBLE_VERSION required (found $ANSIBLE_VERSION)."
  exit 1
fi

echo "Installing Ansible Galaxy collections..."
ansible-galaxy collection install -r requirements.yml

ANSIBLE_OPTIONS=""
if [[ "$OSTYPE" == "linux-gnu"* ]] || [[ "$OSTYPE" == "darwin"* ]]; then
  ANSIBLE_OPTIONS="-K"
fi

echo "Running playbook..."
ansible-playbook local.yml $ANSIBLE_OPTIONS

echo "Setup complete!"
