#!/bin/bash
if ! command -v ansible &> /dev/null; then
  if command -v brew &> /dev/null; then
    brew install ansible
  else
    sudo apt update && sudo apt install ansible -y
  fi
fi

ansible-galaxy collection install -r requirements.yml

ANSIBLE_OPTIONS=""
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  ANSIBLE_OPTIONS="-K"
fi

ansible-playbook local.yml $ANSIBLE_OPTIONS
