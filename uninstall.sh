#!/bin/bash

# Uninstall script for the Prompt Qwen Plugin

set -e  # Exit on any error

PLUGIN_NAME="prompt-qwen-plugin"
PLUGIN_DIR="$HOME/.claude/$PLUGIN_NAME"
COMMANDS_DIR="$HOME/.claude/commands"

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

# Check if plugin directory exists
if [ ! -d "$PLUGIN_DIR" ]; then
    print_error "Plugin directory does not exist at $PLUGIN_DIR"
    print_error "Plugin may not be installed or already uninstalled"
    exit 1
fi

# Remove plugin directory
print_status "Removing plugin directory..."
rm -rf "$PLUGIN_DIR"

# Remove command files
print_status "Removing command files..."
rm -f "$COMMANDS_DIR/create-prompt.toml"
rm -f "$COMMANDS_DIR/run-prompt.toml"
rm -f "$COMMANDS_DIR/add-to-todos.toml"
rm -f "$COMMANDS_DIR/check-todos.toml"
rm -f "$COMMANDS_DIR/whats-next.toml"

print_status "Plugin uninstallation completed successfully!"
