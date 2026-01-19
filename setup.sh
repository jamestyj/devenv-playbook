#!/bin/bash
if ! command -v ansible &> /dev/null; then
  if command -v brew &> /dev/null; then
    brew install ansible
  else
    sudo apt update && sudo apt install ansible
  fi
fi
ansible-galaxy collection install -r requirements.yml
ansible-playbook local.yml -K -v