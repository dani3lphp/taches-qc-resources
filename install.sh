#!/bin/bash

# Install script for the Prompt Qwen Plugin

set -e  # Exit on any error

PLUGIN_NAME="prompt-qwen-plugin"
PLUGIN_DIR="$HOME/.claude/$PLUGIN_NAME"
COMMANDS_DIR="$HOME/.claude/commands"
SKILLS_DIR="$HOME/.claude/skills"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" >&2
}

# Check if Claude Code directories exist
if [ ! -d "$HOME/.claude" ]; then
    print_error "Claude Code directory does not exist at $HOME/.claude"
    print_error "Please install Claude Code first"
    exit 1
fi

# Create directories if they don't exist
mkdir -p "$COMMANDS_DIR"
mkdir -p "$SKILLS_DIR"

# Copy plugin files to Claude directory
print_status "Installing plugin files..."
if [ -d "$PLUGIN_DIR" ]; then
    print_warning "Plugin directory already exists. Updating..."
    rm -rf "$PLUGIN_DIR"
fi

cp -r . "$PLUGIN_DIR"

# Copy command files to Claude commands directory
print_status "Installing commands..."
cp -r ./meta-prompting/*.toml "$COMMANDS_DIR/"
cp -r ./todo-management/*.toml "$COMMANDS_DIR/"

# Install context handoff command
cp -r ./context-handoff/whats-next.toml "$COMMANDS_DIR/"

print_status "Plugin installation completed successfully!"
print_status "You can now use the following commands in Claude Code:"
print_status "  - /create-prompt"
print_status "  - /run-prompt"
print_status "  - /add-to-todos"
print_status "  - /check-todos"
print_status "  - /whats-next"
