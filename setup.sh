#!/bin/bash
ansible-galaxy collection install -r requirements.yml
ansible-playbook roles/main.yml -K -v