#!/bin/sh

# Setup Git hooks for local development

if ! command -v ansible-lint >/dev/null 2>&1; then
  echo "Installing ansible-lint..."
  brew install ansible-lint
fi

if ! command -v shellcheck >/dev/null 2>&1; then
  echo "Installing shellcheck..."
  brew install shellcheck
fi

echo "Configuring Git hooks directory..."
git config core.hooksPath hooks

echo "Git hooks configured successfully!"
