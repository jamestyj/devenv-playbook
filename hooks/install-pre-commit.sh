#!/bin/sh

# Setup Git hooks for local development

HOOKS_DIR=".git/hooks"
REPO_HOOKS_DIR="../../hooks" # Relative path from .git/hooks

echo "Installing dependencies..."
brew install ansible-lint

echo "Installing Git hooks..."
ln -sf "$REPO_HOOKS_DIR/pre-commit" "$HOOKS_DIR/pre-commit"

echo "Git hook installed successfully (symlinked)!"
